//
//  CardHoliday.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CardHoliday: View {
    let info: DateInfo
    let baseColor: Color
    let day : String
    let holiday: Holiday?
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if let h = holiday {
                        Text(h.name ?? "")
                            .font(Font.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(baseColor)
                    }else{
                        if !info.s公历节日.isEmpty{
                            Text(info.s公历节日)
                                .font(Font.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(baseColor)
                        }
                        if !info.s农历节日.isEmpty{
                            Text(info.s农历节日)
                                .font(Font.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(baseColor)
                        }
                        if !info.s特殊节日.isEmpty{
                            Text(info.s特殊节日)
                                .font(Font.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(baseColor)
                        }
                    }
                }
                Spacer()
            }
            
            Text(day)
                .font(Font.system(size: 200))
                .fontWeight(.bold)
                .foregroundColor(baseColor)
            
            if let h = holiday {
                VStack{
                    HStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(h.holiday ? Color("Red_Color") : Color("Green_Color"))
                            
                            Text(h.holiday ? "休" : "班")
                                .font(.system(size: 30))
                                .fontWeight(.medium)
                                .padding(.all, 20.0)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Spacer()
                }
            }
        }
        .frame(width: 270.0, height: 270.0)
    }
}

struct CardHoliday_Previews: PreviewProvider {
    static var previews: some View {
        CardHoliday(info: DateInfo(s公历日期: "2021-01-15",
                                   s公历年: 2021,
                                   s公历月: 01,
                                   s公历日: 15,
                                   s星期: "星期五",
                                   s农历年: "2020",
                                   s农历月: "腊月",
                                   s农历日: "初三",
                                   s年干支: "庚子",
                                   s月干支: "己丑",
                                   s日干支: "甲子",
                                   s闰月: "4",
                                   s属相: "鼠",
                                   s节气: "",
                                   s节气时间: "",
                                   s公历节日: "愚人节",
                                   s农历节日: "",
                                   s特殊节日: "",
                                   s数九数伏: "三九第九天"),
                    baseColor: .green,
                    day: "20",
                    holiday: nil)
    }
}
