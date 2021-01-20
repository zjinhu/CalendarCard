//
//  CalenderDay.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/20.
//

import SwiftUI

struct CalenderDay: View {
    @Environment(\.calendar) var calendar
    let date: Date
    var body: some View {
        VStack{
            Text(String(self.calendar.component(.day, from: date)))
                .frame(width: 40, height: 40, alignment: .center)
                .background(Color.blue)
                .clipShape(Circle())
                .padding(.vertical, 4)
            Text(getInfo(date: date))
        }
    }
    
    func getInfo(date: Date) -> String{
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        //日期格式和输出
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
        return formatter.string(from: date)
    }
}

struct CalenderDay_Previews: PreviewProvider {
    static var previews: some View {
        CalenderDay(date: Date())
    }
}
