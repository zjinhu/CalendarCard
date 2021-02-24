//
//  DateTool.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/12.
//

import Foundation

extension Date {
    
    func getNotiDate() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "MM月dd日 "
        return formater.string(from: self) + getWeekDayString()
    }
    
    func getNotiTime() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "HH:mm"
        return formater.string(from: self)
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



