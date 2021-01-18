//
//  CardItem.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CardItem: View {
    @ObservedObject var request: Request = Request()

    init(info: DateInfo) {
        
        let y = info.s公历月 > 9 ? "\(info.s公历月)" : "0\(info.s公历月)"
        let r = info.s公历日 > 9 ? "\(info.s公历日)" : "0\(info.s公历日)"
        
        request.getHoliday("\(info.s公历年)-\(y)-\(r)")
        
        current = info
    }
    
    var baseColor: Color = .green
    
    var current: DateInfo?
    
    var body: some View {
        
        ZStack{
            VStack {
                
                if let info = current{
                    
                    CardBar(baseColor: request.holiday?.type?.type == 1 || request.holiday?.type?.type == 2 ? Color("Red_Color") : Color("Green_Color"))
                    
                    CardHead(info: info, baseColor: request.holiday?.type?.type == 1 || request.holiday?.type?.type == 2 ? Color("Red_Color") : Color("Green_Color"))
                        .padding([.top, .leading, .trailing])
                    
                    Spacer()
                    
                    CardHoliday(holiday: request.holiday?.holiday, baseColor: request.holiday?.type?.type == 1 || request.holiday?.type?.type == 2 ? Color("Red_Color") : Color("Green_Color"), day: "\(info.s公历日)")
                    
                    Spacer()
                    
                    CardBottom(info: info, baseColor: request.holiday?.type?.type == 1 || request.holiday?.type?.type == 2 ? Color("Red_Color") : Color("Green_Color"))
                        .padding([.leading, .bottom, .trailing], 10.0)
                }

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
                                s数九数伏: "四九第四天"))
    }
}
