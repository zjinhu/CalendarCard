//
//  CardItemView.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/12.
//

import SwiftUI

struct CardItemView: View {
  let info: DateInfo

  var body: some View {
    GeometryReader { geo in
      VStack {
        
        CardHead(info: info)
            .padding([.top, .leading, .trailing])
        
        HStack{
            if !info.s公历节日.isEmpty{
                Text(info.s公历节日)
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)
            }
            if !info.s农历节日.isEmpty{
                Text(info.s农历节日)
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)
            }
            if !info.s特殊节日.isEmpty{
                Text(info.s特殊节日)
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)
            }
        }
        .padding(.top, 30.0)
        
        Spacer()
        
        Text("\(info.s公历日)")
            .font(Font.system(size: 200))
            .fontWeight(.bold)
        
        Spacer()
        CardBottom(info: info)
            .padding([.leading, .bottom, .trailing], 10.0)

      }
      .background(Color.white)
      .cornerRadius(12)
      .shadow(radius: 4)

    }
  }

}

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView(info: DateInfo(s公历日期: "2021-01-20",
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

