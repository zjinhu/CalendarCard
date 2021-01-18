//
//  FootRight.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct FootRight: View {
    let info: DateInfo
    let baseColor: Color
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(Item.getWeek(week: info.s星期))
                    .font(.system(size: 16))
                    .foregroundColor(baseColor)
                Spacer()
            }
            .frame(height: 30.0)
            .background(Color("Bottom_Color"))
            
            Text(info.s星期)
                .font(Font.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color("Bottom_Color"))
        }
        .background(baseColor)
        .border(baseColor, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
    }
}

struct FootRight_Previews: PreviewProvider {
    static var previews: some View {
        FootRight(info: DateInfo(s公历日期: "2021-01-15",
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
                                 s公历节日: "",
                                 s农历节日: "",
                                 s特殊节日: "",
                                 s数九数伏: "三九第九天"), baseColor: .green)
    }
}
