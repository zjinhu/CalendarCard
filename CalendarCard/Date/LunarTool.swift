//
//  LunarTool.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/22.
//

import Foundation
import SwiftCSV

extension Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}

struct ResourceHelper {
    static func url(forResource name: String, withExtension type: String) -> URL? {
        let bundle = Bundle.main
        
        if let url = bundle.url(forResource: name, withExtension: type) {
            return url
        }
        return nil
    }
}

struct DateInfo {
    
    var s公历日期: String
    
    var s公历年: Int
    var s公历月: Int
    var s公历日: Int
    
    var s星期: String
    
    var s农历年: String
    var s农历月: String
    var s农历日: String
    
    var s年干支: String
    var s月干支: String
    var s日干支: String
    
    var s闰月: String
    var s属相: String
    
    var s节气: String
    var s节气时间: String
    
    var s公历节日: String
    var s农历节日: String
    var s特殊节日: String
    var s数九数伏: String
}

struct LunarTool {
    
    static let chineseHoliDay:[String:String] = ["1-1":"春节",
                                                 "1-15":"元宵节",
                                                 "2-2":"龙抬头",
                                                 "5-5":"端午",
                                                 "7-7":"七夕",
                                                 "7-15":"中元",
                                                 "8-15":"中秋",
                                                 "9-9":"重阳",
                                                 "12-8":"腊八",
                                                 "12-23":"小年(北)",
                                                 "12-24":"小年(南)",
                                                 "12-30":"除夕"]
    
    static let gregorianHoliDay:[String:String] = ["1-1":"元旦",
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
    
    
    static func getDay(date: Date) -> String{
        return String(Calendar.current.component(.day, from: date))
    }
    
    static func getInfo(date: Date) -> String{
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
    
    static func getHoliday(date: Date) -> Int{
        /// 0: 普通 1: 周末 2: 周末(班) 3: 普通(休) 4:周末(休)
        
        let formater = DateFormatter()
        formater.dateFormat = "MM-dd"
        let key =  formater.string(from: date)
        
        let holiday = Request.shared.getInfo(key)
        
        let week = date.getWeekDay()
        
        switch week {
        case 7, 1:
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
    
    static func stringConvertDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    static func loadDate() -> [String] {
        return dates(for: Date().endOfCurrentYear().toString())
    }
    
    ///获取今天到年底共计多少天
    static func dates(for date: String) -> [String] {
        // For calendrical calculations you should use noon time
        // So lets get endDate's noon time
        guard let endDate = Formatter.date.date(from: date)?.noon else { return [] }
        // then lets get today's noon time
        var date = Date().startOfCurrentYear()
        var dates: [String] = []
        // while date is less than or equal to endDate
        while date <= endDate {
            // add the formatted date to the array
            dates.append( Formatter.date.string(from: date))
            // increment the date by one day
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        return dates
    }
    ///获取日期的信息
    static func getDateInfo(date: Date) -> DateInfo?{
        
        let count = date.daysBetweenDate(toDate: date.startOfCurrentYear())
        
        let info = date.getDateInfo()
        
        guard let csvURL = ResourceHelper.url(forResource: "\(info.0)", withExtension: "csv") else {
            return nil
        }
        
        let csv = try? CSV(url: csvURL)
        guard let wnl = csv?.enumeratedRows[count] else {
            return nil
        }
        
        return DateInfo(s公历日期: wnl[0],
                        s公历年: info.0,
                        s公历月: info.1,
                        s公历日: info.2,
                        s星期: wnl[1],
                        s农历年: wnl[2],
                        s农历月: wnl[3],
                        s农历日: wnl[4],
                        s年干支: wnl[5],
                        s月干支: wnl[8],
                        s日干支: wnl[9],
                        s闰月: wnl[7],
                        s属相: wnl[6],
                        s节气: wnl[10],
                        s节气时间: wnl[11],
                        s公历节日: wnl[12],
                        s农历节日: wnl[13],
                        s特殊节日: wnl[14],
                        s数九数伏: wnl[15])
        
    }
    
    static func getMonth(index: Int) -> String{
        switch index {
        case 1:
            return "JANUARY"
        case 2:
            return "FEBRUARY"
        case 3:
            return "MARCH"
        case 4:
            return "APRIL"
        case 5:
            return "MAY"
        case 6:
            return "JUNE"
        case 7:
            return "JULY"
        case 8:
            return "AUGUST"
        case 9:
            return "SEPTEMBER"
        case 10:
            return "OCTOBER"
        case 11:
            return "NOVEMBER"
        case 12:
            return "DECEMBER"
        default:
            return ""
        }
    }
    
    static func getWeek(week: String) -> String{
        switch week {
        case "星期一":
            return "MONDAY"
        case "星期二":
            return "TUESDAY"
        case "星期三":
            return "WEDNESDAY"
        case "星期四":
            return "THURSDAY"
        case "星期五":
            return "FRIDAY"
        case "星期六":
            return "SATURDAY"
        case "星期日":
            return "SUNDAY"
        default:
            return ""
        }
    }
    
    static func getWeek(week: Int) -> String{
        switch week {
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        case 7:
            return "周日"
        default:
            return ""
        }
    }
    
    static func getImageName(name: String) -> String{
        switch name {
        case "鼠":
            return "s1"
        case "牛":
            return "s2"
        case "虎":
            return "s3"
        case "兔":
            return "s4"
        case "龙":
            return "s5"
        case "蛇":
            return "s6"
        case "马":
            return "s7"
        case "羊":
            return "s8"
        case "猴":
            return "s9"
        case "鸡":
            return "s10"
        case "狗":
            return "s11"
        case "猪":
            return "s12"
        default:
            return ""
        }
    }
    
    
    
}
