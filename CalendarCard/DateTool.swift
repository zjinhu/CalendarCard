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
        let components = calendar.dateComponents(Set<Calendar.Component>([.year]), from: self)
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
    
    
    static func suitAndAvoid(month: String, rizhi: String) -> ([String], [String]){
        
        var indexMonth = -1
        switch month {
        case "正月":
            indexMonth = 0
        case "二月","闰二月":
            indexMonth = 1
        case "三月","闰三月":
            indexMonth = 2
        case "四月","闰四月":
            indexMonth = 3
        case "五月","闰五月":
            indexMonth = 4
        case "六月","闰六月":
            indexMonth = 5
        case "七月","闰七月":
            indexMonth = 6
        case "八月","闰八月":
            indexMonth = 7
        case "九月","闰九月":
            indexMonth = 8
        case "十月","闰十月":
            indexMonth = 9
        case "冬月","闰冬月":
            indexMonth = 10
        case "腊月":
            indexMonth = 11
        default:
            indexMonth = -1
        }
        
        let dizhi: String = String(rizhi.suffix(1))
        
        guard let jian = get12jian(month: indexMonth, rizhi: dizhi) else {
            return ([], [])
        }
        return getSuitAndAvoid(jian: jian)
    }
    /**
     * 月支日支    一月寅节    二月卯节    三月辰节    四月巳节    五月午节    六月未节    七月申节    八月酉节    九月戍节    十月亥节    十一子节    十二丑节
     * 子            开       收           成       危           破       执           定       平           满       除           建       闭
     * 丑            闭       开           收       成           危        破          执        定          平       满           除       建
     * 寅            建       闭           开       收           成       危           破       执           定       平           满       除
     * 卯            除       建           闭       开           收       成           危       破           执       定           平       满
     * 辰            满        除          建        闭          开       收            成      危           破       执           定       平
     * 巳            平       满           除       建           闭       开           收       成           危       破           执        定
     * 午            定       平            满      除           建       闭           开        收          成       危           破       执
     * 未            执       定           平       满           除       建           闭       开           收       成           危       破
     * 申            破       执           定       平           满       除           建       闭           开       收           成       危
     * 酉            危       破           执        定          平       满           除       建           闭       开           收       成
     * 戍            成       危           破       执           定       平            满      除           建       闭           开       收
     * 亥            收       成           危       破           执       定           平       满           除       建           闭       开
     */
    
   fileprivate static let huangliData = [
        ["开","收","成","危","破","执","定","平","满","除","建","闭"],
        ["闭","开","收","成","危","破","执","定","平","满","除","建"],
        ["建","闭","开","收","成","危","破","执","定","平","满","除"],
        ["除","建","闭","开","收","成","危","破","执","定","平","满"],
        ["满","除","建","闭","开","收","成","危","破","执","定","平"],
        ["平","满","除","建","闭","开","收","成","危","破","执","定"],
        ["定","平","满","除","建","闭","开","收","成","危","破","执"],
        ["执","定","平","满","除","建","闭","开","收","成","危","破"],
        ["破","执","定","平","满","除","建","闭","开","收","成","危"],
        ["危","破","执","定","平","满","除","建","闭","开","收","成"],
        ["成","危","破","执","定","平","满","除","建","闭","开","收"],
        ["收","成","危","破","执","定","平","满","除","建","闭","开"]
    ]
    
    fileprivate static let riganzhi = ["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
    ///参数 农历月 日干支
    fileprivate static func get12jian(month: Int, rizhi: String) -> String?{
        if month < 0 || month > 11{
            return nil
        }
        let index = getHuangliIndex(rizhi: rizhi)
        return huangliData[index][month]
    }
    
    fileprivate static func getHuangliIndex(rizhi: String) -> Int{
        for (index, str) in riganzhi.enumerated() {
            if str == rizhi{
                return index
            }
        }
        return -1
    }
    /**
     *通胜十二建
     建、除、满、平、定、执、破、危、成、收、开、闭。 吉日：红白二事皆宜的日子。
     成日：成功、天帝纪万物成就的大吉日子，凡事皆顺。
     宜：结婚、开市、修造、动土、安床、破土、安葬、搬迁、    交易、求财、出行、立契、竖柱、裁种、牧养。  忌：诉讼。
     
     收日：收成、收获，天帝宝库收纳的日子。
      宜：祈福、求嗣、赴任、嫁娶、安床、修造、动土、    求学、开市、交易、买卖、立契。  忌：放债、新船下水、新车下地、破土、安葬。
     
     
     开日：开始、开展的日子。
      宜：祭祀、祈福、入学、上任、修造、动土、    开市、安床、交易、出行、竖柱。  忌：放债、诉讼、安葬。 次吉：吉日后，退而求其次的日子。
     
     建日：万物生育、强健、健壮的日子。
      
     宜：赴任、祈福、求嗣、破土、安葬、修造、上梁、求财、    置业、入学、考试、结婚、动土、签约、交涉、出行。
      忌：动土、开仓、掘井、乘船、新船下水、新车下地、维修水电器具。
     
     除日：扫除恶煞、去旧迎新的日子。
      宜：祭祀、祈福、婚姻、出行、入伙、搬迁、出货、动土、求医、交易。  忌：结婚、赴任、远行、签约。
     
     满日：丰收、美满、天帝宝库积满的日子。
      宜：嫁娶、祈福、移徙、开市、交易、求财、立契、祭祀、出行、牧养。  忌：造葬、赴任、求医。
     
     平日：普通的日子。
     
     平日：平常、官人集合平分的日子。
      宜：嫁娶、修造、破土、安葬、牧养、开市、安床、动土、求嗣。  忌：祈福、求嗣、赴任、嫁娶、开市、安葬。
     
     定日：安定、平常、天帝众客定座的日子。
      宜：祭祀、祈福、嫁娶、造屋、装修、修路、开市、入学、上任、入伙。  忌：诉讼、出行、交涉。
     
     
     凶日：诸事不宜，最好避之则吉，喜事更可免则免。
     执日：破日之从神，曰小耗，天帝执行万物赐天福，较差的日子。
     宜：造屋、装修、嫁娶、收购、立契、祭祀。  忌：开市、求财、出行、搬迁。
     
     
     * 破日：日月相冲，曰大耗，斗柄相冲相向必破坏的日子，大事不宜。
     * 宜：破土、拆卸、求医。
      忌：嫁娶、签约、交涉、出行、搬迁。
     
     危日：危机、危险，诸事不宜的日子。
     宜：祭祀、祈福、安床、拆卸、破土。  忌：登山、乘船、出行、嫁娶、造葬、迁徙。
     
     闭日：十二建中最后一日，关闭、收藏、天地阴阳闭寒的日子。  宜：祭祀、祈福、筑堤、埋池、埋穴、造葬、填补、修屋。  忌：开市、出行、求医、手术、嫁娶。
     * param shierjianString 通胜十二建字符串
     */
    
    fileprivate static let jianSuit = ["祈福","求嗣","破土","安葬","修造","求财"]
    fileprivate static let jianAvoid = ["动土","开仓","掘井","乘船"]
    
    fileprivate static let chuSuit = ["祭祀","婚姻","出行","搬迁","动土","交易"]
    fileprivate static let chuAvoid = ["结婚","赴任","远行","签约"]
    
    fileprivate static let manSuit = ["嫁娶","祈福","移徙","开市","求财","立契"]
    fileprivate static let manAvoid = ["造葬","赴任","求医"];
    
    fileprivate static let pingSuit = ["嫁娶","修造","破土","安葬","开市","求嗣"]
    fileprivate static let pingAvoid = ["祈福","求嗣","赴任"]
    
    fileprivate static let dingSuit = ["祭祀","祈福","嫁娶","造屋","装修","开市"]
    fileprivate static let dingAvoid = ["诉讼","出行","交涉"]
    
    fileprivate static let zhiSuit = ["造屋","装修","嫁娶","收购","立契","祭祀"]
    fileprivate static let zhiAvoid = ["开市","求财","出行","搬迁"]
    
    fileprivate static let poSuit = ["破土","拆卸","求医"]
    fileprivate static let poAvoid = ["嫁娶","签约","交涉","出行","搬迁"]
    
    fileprivate static let weiSuit = ["祭祀","祈福","安床","拆卸","破土"]
    fileprivate static let weiAvoid = ["登山","乘船","出行","嫁娶","造葬","迁徙"]
    
    fileprivate static let chengSuit = ["结婚","开市","修造","搬迁","出行","立契"]
    fileprivate static let chengAvoid = ["诉讼"]
    
    fileprivate static let shouSuit = ["祈福","求嗣","赴任","嫁娶","修造","开市"]
    fileprivate static let shouAvoid = ["放债","新船下水","新车下地","破土"]
    
    fileprivate static let kaiSuit = ["祭祀","祈福","上任","修造","动土","开市"]
    fileprivate static let kaiAvoid = ["放债","诉讼","安葬"]
    
    fileprivate static let biSuit = ["祭祀","祈福","筑堤","埋穴","造葬","修屋"]
    fileprivate static let biAvoid = ["开市","出行","求医","手术","嫁娶"]
    
    fileprivate static func getSuitAndAvoid(jian: String) -> ([String], [String]){

        switch jian {
        case "建":
            return (jianSuit, jianAvoid)
        case "除":
            return (chuSuit, chuAvoid)
        case "满":
            return (manSuit, manAvoid)
        case "平":
            return (pingSuit, pingAvoid)
        case "定":
            return (dingSuit, dingAvoid)
        case "执":
            return (zhiSuit, zhiAvoid)
        case "破":
            return (poSuit, poAvoid)
        case "危":
            return (weiSuit, weiAvoid)
        case "成":
            return (chengSuit, chengAvoid)
        case "收":
            return (shouSuit, shouAvoid)
        case "开":
            return (kaiSuit, kaiAvoid)
        case "闭":
            return (biSuit, biAvoid)
        default:
            return([], [])
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

