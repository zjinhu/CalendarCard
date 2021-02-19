//
//  PublicUtil.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/22.
//

import Foundation

extension Calendar {
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}

extension Date {
    
    var calendar: Calendar {
        return Calendar(identifier: Calendar.current.identifier)
    }


    func isToday() -> Bool{
        return calendar.isDateInToday(self)
    }
    
    func isInMonth() -> Bool{
        if calendar.isDate(self, equalTo: Date(), toGranularity: .month) {
            return true
        } else {
            return false
        }
    }
    ///获取当前Date所在周的周一到周日
    func getWeekStart() -> DateInterval{
        var date = self
        ///因为一周的起始日是周日,周日已经算是下一周了
        ///如果是周日就到退回去两天
        let weekCount = date.getWeekDay()
        if weekCount == 1 {
            date = date.addingTimeInterval(-60 * 60 * 24 * 2)
        }
        ///使用处理后的日期拿到这一周的间距: 周日到周六
        let week = calendar.dateInterval(of: .weekOfMonth, for: date)!
        ///处理一下周日加一天到周一
        let monday = week.start.addingTimeInterval(60 * 60 * 24)
        ///周六加一天到周日
        let sunday = week.end.addingTimeInterval(60 * 60 * 24)
        ///生成新的周一到周日的间距
        let interval = DateInterval(start: monday, end: sunday)
        return interval
    }
    
    func getWeekEnd() -> DateInterval{
        var date = self
        ///因为一周的起始日是周日,周日已经算是下一周了
        ///如果是周日就到退回去两天
        let weekCount = date.getWeekDay()
        if weekCount <= 2 {
            date = date.addingTimeInterval(-60 * 60 * 24 * 2)
        }
        ///使用处理后的日期拿到这一周的间距: 周日到周六
        let week = calendar.dateInterval(of: .weekOfMonth, for: date)!
        ///处理一下周日加一天到周一
        let monday = week.start.addingTimeInterval(60 * 60 * 24)
        ///周六加一天到周日
        let sunday = week.end.addingTimeInterval(60 * 60 * 24)
        ///生成新的周一到周日的间距
        let interval = DateInterval(start: monday, end: sunday)
        return interval
    }
    
    func getWeekDays() -> [Date] {
        return calendar.generateDates(
            inside: DateInterval(start: self.getWeekStart().start, end: self.getWeekStart().end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    func getMonthDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: self) else { return [] }
        let monthFirstWeek = monthInterval.start.getWeekStart()
        let monthLastWeek = monthInterval.end.getWeekEnd()
        
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    var noon: Date {
        return calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    func getHolidayKey() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "MM-dd"
        return formater.string(from: self)
    }
    
    func getYear() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "yyyy"
        return formater.string(from: self)
    }
    
    
    func daysBetweenDate(toDate: Date) -> Int {
        let components = calendar.dateComponents([.day], from: toDate, to: self)
        return components.day ?? 0
    }
    
    func getWeekDay() -> Int{
        ///拿到现在的week数字
        let components = calendar.dateComponents([.weekday], from: self)
        let weekCount = components.weekday!
        return weekCount
    }
    
    func isWeekDay() -> Bool{
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday!==1 || components.weekday!==7 ? true : false
    }
    
    func getWeekDayString() -> String{
        let array = ["","周日","周一","周二","周三","周四","周五","周六"]
        return array[getWeekDay()]
    }
    
    func toString() -> String{
        let formater = DateFormatter()
        formater.locale = Locale(identifier: "zh_CN")
        formater.dateFormat = "yyyy-MM-dd"
        return formater.string(from: self)
    }
    
    func toYearString() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "yyyy年M月"
        return formatter.string(from: self)
    }
    
    func getDateInfo() -> (Int, Int, Int){
        let comp = calendar.dateComponents([.year, .month, .day], from: self)
        return (comp.year!, comp.month!, comp.day!)
    }
    
    func getLunar() -> (String, String){
        //初始化农历日历
        let lunarCalendar = Calendar.init(identifier: .chinese)
        
        ///获得农历月
        let lunarMonth = DateFormatter()
        lunarMonth.locale = Locale(identifier: "zh_CN")
        lunarMonth.dateStyle = .medium
        lunarMonth.calendar = lunarCalendar
        lunarMonth.dateFormat = "MMM"
        
        let month = lunarMonth.string(from: self)
        
        //获得农历日
        let lunarDay = DateFormatter()
        lunarDay.locale = Locale(identifier: "zh_CN")
        lunarDay.dateStyle = .medium
        lunarDay.calendar = lunarCalendar
        lunarDay.dateFormat = "d"
        
        let day = lunarDay.string(from: self)

        return (month, day)
        
    }
    
    //本年开始日期
    func startOfCurrentYear() -> Date {
        let components = calendar.dateComponents(Set<Calendar.Component>([.year]), from: self)
        let startOfYear = calendar.date(from: components)!
        return startOfYear
    }
    
    //本年结束日期
    func endOfCurrentYear(returnEndTime: Bool = false) -> Date {
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
}

struct SuitAvoid {

    static func suitAndAvoid(date: Date, isSuit: Bool) -> [String] {
        
        let month = date.getLunar().0
        let rizhi = getRiGanZhi(date: date)
        
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
            return []
        }
        if isSuit{
            return getSuitAndAvoid(jian: jian).0
        }else{
            return getSuitAndAvoid(jian: jian).1
        }

    }
    
    fileprivate static let ganZhi = ["甲子","乙丑","丙寅","丁卯","戊辰","己巳","庚午","辛未","壬申","癸酉",
                                     "甲戌","乙亥","丙子","丁丑","戊寅","己卯","庚辰","辛巳","壬午","癸未",
                                     "甲申","乙酉","丙戌","丁亥","戊子","己丑","庚寅","辛卯","壬辰","癸巳",
                                     "甲午","乙未","丙申","丁酉","戊戌","己亥","庚子","辛丑","壬寅","癸丑",
                                     "甲辰","乙巳","丙午","丁未","戊申","己酉","庚戌","辛亥","壬子","癸丑",
                                     "甲寅","乙卯","丙辰","丁巳","戊午","己未","庚申","辛酉","壬戌","癸亥"]
    
    fileprivate static func getRiGanZhi(date: Date)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.date(from: "2019/07/26")
        let count = date.daysBetweenDate(toDate: someDateTime!)
        let index = count%60
        let ganzhi = ganZhi[index]
//        print("\(date)--\(ganzhi)")
        return ganzhi
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
    
    fileprivate static let poSuit = ["破土","拆卸"]
    fileprivate static let poAvoid = ["是日值月破,大事不宜"]
    
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
