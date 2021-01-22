//
//  CalendarList.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CalendarList: View {
    //    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @Environment(\.presentationMode) var mode
    @Environment(\.calendar) var calendar
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0, content: {
            CalendarWeek()
                .frame(height: 30.0)
            
            CalendarView(interval: year) { date in
                CalenderDay(day: LunarTool.getDay(date: date),
                            lunar: LunarTool.getInfo(date: date),
                            status: LunarTool.getHoliday(date: date),
                            isToday: calendar.isDateInToday(date))
                    .onTapGesture {
                        mode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let count = Date.dayCount(selectDate: date.transDate())
                            NotificationCenter.default.post(name: NSNotification.Name.init("ReloadCard"), object: count)
                        }
                    }
            }
        })
        .padding([.leading, .trailing], 10.0)
        
    }
    
    
}

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}
