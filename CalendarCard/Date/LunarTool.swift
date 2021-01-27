//
//  LunarTool.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/22.
//

import Foundation

extension Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale(identifier: "zh_CN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
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
                                                   "4-1":"愚人节",
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
    
    static func isWeekEnd(date: Date) -> Bool{
        let week = date.getWeekDay()
        switch week {
        case 7, 1:
            return true
        default:
            return false
        }
    }
    
    fileprivate static let shengxiao = ["鼠", "牛", "虎", "兔", "龙", "蛇", "马", "羊", "猴", "鸡", "狗", "猪"]
    fileprivate static let tiangan = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]
    fileprivate static let dizhi = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
    
    
    ///农历年转生肖
    static func getShengXiao(withYear year: Int) -> String {
        let index: Int = (year - 1) % shengxiao.count
        return shengxiao[index]
    }
        
    static func getShengXiao(withDate date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return getShengXiao(withYear: calendar.component(.year, from: date))
    }
    
    ///农历年转干支
    static func getNianGanZhi(withYear year: Int) -> String {
        let indexTiangan: Int = (year - 1) % tiangan.count
        let indexDizhi: Int = (year - 1) % dizhi.count
        return tiangan[indexTiangan] + dizhi[indexDizhi]
    }
    
    static func getNianGanZhi(withDate date: Date) -> String {
        let calendar: Calendar = Calendar(identifier: .chinese)
        return getNianGanZhi(withYear: calendar.component(.year, from: date))
    }
    
    static func getJieRi(date: Date) -> String?{
        
        let pu = DateFormatter()
        pu.locale = Locale(identifier: "zh_CN")
        pu.dateFormat = "M-d"
        let gregorian = pu.string(from: date)
        
        let lunarCalendar = Calendar.init(identifier: .chinese)
        let lu = DateFormatter()
        lu.locale = Locale(identifier: "zh_CN")
        lu.dateStyle = .short
        lu.calendar = lunarCalendar
        lu.dateFormat = "M-d"
        let lunar = lu.string(from: date)
        
        if let holiday = chineseHoliDay[lunar] {
            return holiday
        }
        
        if let holiday = gregorianHoliDay[gregorian] {
            return holiday
        }
        
        return nil
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
        
        
        let month = yue.string(from: date)
        let day = ri.string(from: date)
        
        if let holiday = getJieRi(date: date) {
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
    
    static func getWeekEng(week: Int) -> String{
        switch week {
        case 2:
            return "MONDAY"
        case 3:
            return "TUESDAY"
        case 4:
            return "WEDNESDAY"
        case 5:
            return "THURSDAY"
        case 6:
            return "FRIDAY"
        case 7:
            return "SATURDAY"
        case 1:
            return "SUNDAY"
        default:
            return ""
        }
    }
    
    static func getWeekChn(week: Int) -> String{
        switch week {
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        case 1:
            return "星期日"
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

struct Constellation {

    public static func calculateWithDate(date: Date) -> String {

        let components = Calendar.current.dateComponents([.month, .day], from: date)
        let month = components.month!
        let day = components.day!

        // 月以100倍之月作为一个数字计算出来
        let mmdd = month * 100 + day
        var result = ""
        
        if ((mmdd >= 321 && mmdd <= 331) ||
            (mmdd >= 401 && mmdd <= 419)) {
            result = "白羊座"
        } else if ((mmdd >= 420 && mmdd <= 430) ||
            (mmdd >= 501 && mmdd <= 520)) {
            result = "金牛座"
        } else if ((mmdd >= 521 && mmdd <= 531) ||
            (mmdd >= 601 && mmdd <= 621)) {
            result = "双子座"
        } else if ((mmdd >= 622 && mmdd <= 630) ||
            (mmdd >= 701 && mmdd <= 722)) {
            result = "巨蟹座"
        } else if ((mmdd >= 723 && mmdd <= 731) ||
            (mmdd >= 801 && mmdd <= 822)) {
            result = "狮子座"
        } else if ((mmdd >= 823 && mmdd <= 831) ||
            (mmdd >= 901 && mmdd <= 922)) {
            result = "处女座"
        } else if ((mmdd >= 923 && mmdd <= 930) ||
            (mmdd >= 1001 && mmdd <= 1023)) {
            result = "天秤座"
        } else if ((mmdd >= 1024 && mmdd <= 1031) ||
            (mmdd >= 1101 && mmdd <= 1122)) {
            result = "天蝎座"
        } else if ((mmdd >= 1123 && mmdd <= 1130) ||
            (mmdd >= 1201 && mmdd <= 1221)) {
            result = "射手座"
        } else if ((mmdd >= 1222 && mmdd <= 1231) ||
            (mmdd >= 101 && mmdd <= 119)) {
            result = "摩羯座"
        } else if ((mmdd >= 120 && mmdd <= 131) ||
            (mmdd >= 201 && mmdd <= 218)) {
            result = "水瓶座"
        } else if ((mmdd >= 219 && mmdd <= 229) ||
            (mmdd >= 301 && mmdd <= 320)) {
            //考虑到2月闰年有29天的
            result = "双鱼座"
        }else{
            print(mmdd)
            result = "日期错误"
        }
        return result
    }
    

}
