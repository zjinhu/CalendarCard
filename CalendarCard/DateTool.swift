//
//  DateTool.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/12.
//

import Foundation
extension Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
}

extension Date {
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

struct Item {
    
    static let mock: [String] = dates(for: "2021-12-31")
    
    static func dates(for date: String) -> [String] {
        // For calendrical calculations you should use noon time
        // So lets get endDate's noon time
        guard let endDate = Formatter.date.date(from: date)?.noon else { return [] }
        // then lets get today's noon time
        var date = Date().noon
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
}
