//
//  CardBottom.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct CardBottom: View {
    let info: DateInfo
    let baseColor: Color
    var body: some View {
        VStack{

            Image(Item.getImageName(name: info.s属相))
                .renderingMode(.template)
                .background(Color("BG_Color"))
                .foregroundColor(baseColor)
            
            Text("\(info.s年干支)(\(info.s属相))年 农历\(info.s农历月)")
                .foregroundColor(baseColor)
            
            
           CardHuangli(baseColor: baseColor,
                       suitAndAvoid: Item.suitAndAvoid(month: info.s农历月, rizhi: info.s日干支))
            .padding(.vertical, 5.0)
            
            CardFoot(info: info, baseColor: baseColor)
            
            HStack{
                if !info.s节气.isEmpty{
                    Text(info.s节气)
                        .foregroundColor(baseColor)
                }
                if !info.s节气时间.isEmpty{
                    Text(info.s节气时间)
                        .foregroundColor(baseColor)
                }
                if !info.s数九数伏.isEmpty{
                    Text(info.s数九数伏)
                        .foregroundColor(baseColor)
                }
            }
            .padding(.vertical, 2.0)
        }
    }
}

struct CardBottom_Previews: PreviewProvider {
    static var previews: some View {
        CardBottom(info: DateInfo(s公历日期: "2021-01-15",
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
                                  s节气: "冬至",
                                  s节气时间: "5:48:01",
                                  s公历节日: "",
                                  s农历节日: "",
                                  s特殊节日: "",
                                  s数九数伏: "三九第九天"), baseColor: .green)
    }
}
