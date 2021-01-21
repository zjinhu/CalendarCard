//
//  CalendarList.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI
import SwiftDate

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
                
                CalenderDay(day: getDay(date: date),
                            lunar: getInfo(date: date),
                            status: getHoliday(date: date),
                            isToday: date.isToday)
                    .onTapGesture {
                        mode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let count = Date.dayCount(selectDate: date.transDate())
                            NotificationCenter.default.post(name: NSNotification.Name.init("ReloadCard"), object: count)
                        }
                    }
            }
        }
        .padding([.leading, .bottom, .trailing], 10.0)
        
    }
    
    let chineseHoliDay:[String:String] = ["1-1":"春节",
                                          "1-15":"元宵节",
                                          "2-2":"龙抬头",
                                          "5-5":"端午",
                                          "7-7":"七夕",
                                          "7-15":"中元",
                                          "8-15":"中秋",
                                          "9-9":"重阳",
                                          "12-8":"腊八",
                                          "12-23":"北方小年",
                                          "12-24":"南方小年",
                                          "12-30":"除夕"]
    
    let gregorianHoliDay:[String:String] = ["1-1":"元旦",
                                          "2-14":"情人节",
                                          "3-8":"妇女节",
                                          "3-12":"植树节",
                                          "4-4":"清明",
                                          "5-1":"劳动节",
                                          "5-4":"青年节",
                                          "6-1":"儿童节",
                                          "7-1":"建党节",
                                          "8-1":"建军节",
                                          "10-1":"国庆",
                                          "12-24":"平安夜",
                                          "12-25":"圣诞节"]
    
    
    func getDay(date: Date) -> String{
        return String(self.calendar.component(.day, from: date))
    }
    func getInfo(date: Date) -> String{
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)

        let yue = DateFormatter()
        yue.locale = Locale(identifier: "zh_CN")
        yue.dateStyle = .medium
        yue.calendar = lunarCalendar
        yue.dateFormat = "MMM"
        
        //日期格式和输出
        let ri = DateFormatter()
        ri.locale = Locale(identifier: "zh_CN")
        ri.dateStyle = .medium
        ri.calendar = lunarCalendar
        ri.dateFormat = "d"
        
        let pu = DateFormatter()
        pu.locale = Locale(identifier: "zh_CN")
        pu.dateFormat = "M-d"
        let gregorian = pu.string(from: date)
        
        let lu = DateFormatter()
        lu.locale = Locale(identifier: "zh_CN")
        lu.dateStyle = .short
        lu.calendar = lunarCalendar
        lu.dateFormat = "M-d"
        let lunar = lu.string(from: date)
        
        let month = yue.string(from: date)
        let day = ri.string(from: date)
        
        if let holiday = chineseHoliDay[lunar] {
            return holiday
        }
        
        if let holiday = gregorianHoliDay[gregorian] {
            return holiday
        }

        if day == "初一" {
            return month
        }

        return day
        
    }
    
    func getHoliday(date: Date) -> Int{
        /// 0: 普通 1: 周末 2: 周末(班) 3: 普通(休) 4:周末(休)
        
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd"
        let key =  formater.string(from: date)
        
        let holiday = Request.shared.getInfo(key)
        
        let week = date.weekday
        
        switch week {
        case 7, 6:
            if let h = holiday{
                if h.holiday == true {
                    return 4
                }else{
                    return 2
                }
            }
            return 1
        default:
            if let h = holiday{
                if h.holiday == true {
                    return 3
                }
            }
            return 0
        }
    }
}

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}
