//
//  DateTool.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/12.
//

import Foundation

extension Date {
    ///获取当前Date所在周的周一到周日
    func getWeekStartAndEnd() -> DateInterval{
        var date = self
        ///因为一周的起始日是周日,周日已经算是下一周了
        ///如果是周日就到退回去两天
        if date.getWeekDay() == 1 {
            date = date.addingTimeInterval(-60 * 60 * 24 * 2)
        }
        ///使用处理后的日期拿到这一周的间距: 周日到周六
        let week = Calendar.current.dateInterval(of: .weekOfMonth, for: date)!
        ///处理一下周日加一天到周一
        let monday = week.start.addingTimeInterval(60 * 60 * 24)
        ///周六加一天到周日
        let sunday = week.end.addingTimeInterval(60 * 60 * 24)
        ///生成新的周一到周日的间距
        let interval = DateInterval(start: monday, end: sunday)
        return interval
    }
    
    func todayCount() -> Int {
        let components = Calendar.current.dateComponents([.day], from: startOfCurrentYear(), to: self)
        return components.day ?? 0
    }
    
    static func dayCount(selectDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: Date().startOfCurrentYear(), to: selectDate)
        return components.day ?? 0
    }
    
    func transDate() -> Date {
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        let date = calendar.date(from: comp)!
        return date
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



