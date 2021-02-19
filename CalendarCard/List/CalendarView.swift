//
//  CalendarView.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/18.
//

import SwiftUI

struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    let interval: DateInterval
    let showHeaders: Bool
    let content: (Date) -> DateView
    
    init(interval: DateInterval, showHeaders: Bool = true, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.interval = interval
        self.showHeaders = showHeaders
        self.content = content
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ScrollViewReader { (proxy: ScrollViewProxy) in
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 2, alignment: .center), count: 7)) {
                    ForEach(months, id: \.self) { month in
                        Section(header: header(for: month)) {
                            ForEach(month.getMonthDays(), id: \.self) { date in
                                if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                                    content(date).id(date)
                                } else {
                                    content(date).hidden()
                                }
                            }
                        }
                        .id(sectionID(for: month))
                    }
                }
                .onAppear(){
                    proxy.scrollTo(scroolSectionID() )
                }
            }
        }
        
    }
    
    private func scroolSectionID() -> Int {
        let component = calendar.component(.month, from: Date())
        return component
    }
    
    private func sectionID(for month: Date) -> Int {
        let component = calendar.component(.month, from: month)
        return component
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

    //    private func days(for month: Date) -> [Date] {
    //        guard
    //            let monthInterval = calendar.dateInterval(of: .month, for: month),
    //            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
    //            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
    //        else { return [] }
    //        print("month:\(month)")
    //        print("1:\(monthInterval)/////2:\(monthFirstWeek)/////3:\(monthLastWeek)")
    //        let array = calendar.generateDates(
    //            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
    //            matching: DateComponents(hour: 0, minute: 0, second: 0)
    //        )
    //        return array
    //    }
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


fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月"
        return formatter
    }
    
    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年M月"
        return formatter
    }
}
