//
//  WeekDaysView.swift
//  TodayExtension
//
//  Created by iOS on 2021/2/18.
//

import SwiftUI
import WidgetKit
struct WeekDaysView: View {
    let days: [Date]
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 2, alignment: .center), count: 7)) {
            
            ForEach(days, id: \.self) { date in
                DayView(date: date, status: LunarTool.getHoliday(date: date))
                    .frame(maxWidth: .infinity)
            }
            
        }
        .padding(.horizontal, 5.0)
    }
}

struct WeekDaysView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDaysView(days: Date().getWeekDays())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
