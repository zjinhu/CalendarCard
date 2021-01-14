//
//  FootLeft.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct FootLeft: View {
    let info: DateInfo
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(info.s月干支)月")
                    .font(.system(size: 16))
                Spacer()
                Text("\(info.s日干支)日")
                    .font(.system(size: 16))
                Spacer()
            }
            .frame(height: 30.0)
            .background(Color.white)

            ZStack{
                Text("\(info.s农历月) \(info.s农历日)")
                    .font(Font.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
        }
        .background(Color.red)
        .border(/*@START_MENU_TOKEN@*/Color.red/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
    }
}

struct FootLeft_Previews: PreviewProvider {
    static var previews: some View {
        FootLeft(info: DateInfo(s公历日期: "2021-01-15",
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
                                s数九数伏: "三九第九天"))
    }
}
