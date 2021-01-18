//
//  CalendarView.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/18.
//

import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(months, id: \.self) { month in
                Section(header: header(for: month)) {
                    ForEach(days(for: month), id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date).id(date)
                        } else {
                            content(date).hidden()
                        }
                    }
                }
            }
        }
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month

        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }

    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(interval: .init()) { _ in
            Text("30")
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}
