//
//  CardHead.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct CardHead: View {
    let info: DateInfo
    let baseColor: Color
    var body: some View {
        VStack{
            HStack{
                Text(String(info.s公历年))
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.leading, 10.0)
                    .foregroundColor(baseColor)
                Spacer()
                Text(Item.getMonth(index: info.s公历月))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(baseColor)
                Spacer()
                Text("\(info.s公历月)月")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.trailing, 10.0)
                    .foregroundColor(baseColor)
            }
            .padding(.all, 10.0)
            .frame(height: 50.0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(baseColor, lineWidth: 4)
            )
            
            HStack{
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
            .padding(.top, 30.0)
        }
    }
}

struct CardHead_Previews: PreviewProvider {
    static var previews: some View {
        CardHead(info: DateInfo(s公历日期: "2021-01-15",
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
