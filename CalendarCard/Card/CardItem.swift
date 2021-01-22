//
//  CardItem.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CardItem: View {
    
    init(info: DateInfo, holiday: Holiday?) {
        current = info
        currentHoliday = holiday
        switch info.s星期 {
        case "星期六", "星期日":
            status = 1
        default:
            status = 0
        }
        
        if let h = holiday {
            if h.holiday == true {
                status = 3
            }else{
                status = 2
            }
        }
    }
    
    var current: DateInfo?
    var currentHoliday: Holiday?
    
    var status: Int = 0
    
    var body: some View {
        
        ZStack{
            VStack {
                
                CardBar(baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"))
                
                CardHead(info: current!,
                         baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"))
                    .padding([.top, .leading, .trailing])
                
                Spacer()
                
                CardHoliday(info: current!,
                            baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"),
                            day: "\(current!.s公历日)",
                            holiday: currentHoliday)
                Spacer()
                
                CardBottom(info: current!,
                           baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"))
                    .padding([.leading, .bottom, .trailing], 10.0)
            }
            
        }
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(info: DateInfo(s公历日期: "2021-01-20",
                                s公历年: 2021,
                                s公历月: 01,
                                s公历日: 20,
                                s星期: "星期三",
                                s农历年: "2020",
                                s农历月: "腊月",
                                s农历日: "初八",
                                s年干支: "庚子",
                                s月干支: "己丑",
                                s日干支: "戊辰",
                                s闰月: "4",
                                s属相: "鼠",
                                s节气: "大寒",
                                s节气时间: "4:39:42",
                                s公历节日: "",
                                s农历节日: "腊八节",
                                s特殊节日: "",
                                s数九数伏: "四九第四天"), holiday: Holiday())
    }
}
