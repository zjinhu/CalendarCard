//
//  DateTool.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/12.
//

import Foundation
import SwiftCSV
import SwiftDate
extension Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}

extension Date {
    
    func getWeekStartAndEnd(_ start: Bool = false) -> DateInterval{
        var date = self
        if start {
            date = date + 12.hours
        }
        if date.weekday == 1 {
            date = date - 2.days
        }
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: date)!
        let monday = week.start + 1.days
        let sunday = week.end + 1.days
        let interval = DateInterval(start: monday, end: sunday)
        return interval
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func getYear() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "yyyy"
        return formater.string(from: self)
    }
    
    func getHolidayKey() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "MM-dd"
        return formater.string(from: self)
    }
    
    func toString() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: self)
    }
    
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: toDate, to: self)
        return components.day ?? 0
    }
    
    func todayCount() -> Int {
        let components = Calendar.current.dateComponents([.day], from: startOfCurrentYear(), to: self)
        return components.day ?? 0
    }
    
    static func dayCount(selectDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: Date().startOfCurrentYear(), to: selectDate)
        return components.day ?? 0
    }
    
    func getDateInfo() -> (Int, Int, Int){
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        return (comp.year!, comp.month!, comp.day!)
    }
    
    func transDate() -> Date {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        let date = calendar.date(from: comp)!
        return date
    }
    
    //本年开始日期
    func startOfCurrentYear() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents(Set<Calendar.Component>([.year]), from: self)
        let startOfYear = calendar.date(from: components)!
        return startOfYear
    }
    
    //本年结束日期
    func endOfCurrentYear(returnEndTime: Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfYear = calendar.date(byAdding: components, to: startOfCurrentYear())!
        return endOfYear
    }
    
    //指定年月的开始日期
    func startOfMonth(year: Int, month: Int) -> Date {
        let calendar = Calendar.current
        var startComps = DateComponents()
        startComps.day = 1
        startComps.month = month
        startComps.year = year
        let startDate = calendar.date(from: startComps)!
        return startDate
    }
     
    //指定年月的结束日期
    func endOfMonth(year: Int, month: Int, returnEndTime: Bool = false) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
         
        let endOfYear = calendar.date(byAdding: components,
                                      to: startOfMonth(year: year, month:month))!
        return endOfYear
    }
}

struct Item {
    
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

