//
//  CalendarList.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CalendarList: View {
    
    @Environment(\.presentationMode) var mode
    
    @Environment(\.calendar) var calendar
    
    private var year: DateInterval {
        calendar.dateInterval(of: .year, for: Date())!
    }
    
    var body: some View {
        CalendarView(interval: year) { date in
          Text(String(self.calendar.component(.day, from: date)))
            .frame(width: 40, height: 40, alignment: .center)
            .background(Color.blue)
            .clipShape(Circle())
            .padding(.vertical, 4)
        }
      }
}

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}
