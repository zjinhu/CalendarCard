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
        
        VStack{
            CalendarWeek()
                .frame(height: 40.0)
            
            CalendarView(interval: year) { date in
                
                CalenderDay(date: date)
                    .onTapGesture {
                        mode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let count = Date.dayCount(selectDate: date.transDate())
                            NotificationCenter.default.post(name: NSNotification.Name.init("ReloadCard"), object: count)
                        }
                    }
            }
        }
        .padding(.horizontal, 10.0)
        
    }
}

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}
