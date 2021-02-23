//
//  CardBottom.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct CardBottom: View {
    let date: Date
    let baseColor: Color
    var body: some View {
        VStack{

            Image(LunarTool.getImageName(name: LunarTool.getShengXiao(withDate: date)))
                .renderingMode(.template)
                .background(Color("BG_Color"))
                .foregroundColor(baseColor)
            
            Text("\(LunarTool.getNianGanZhi(withDate: date))(\(LunarTool.getShengXiao(withDate: date)))年 农历\(date.getLunar().0)")
                .foregroundColor(baseColor)
            
            
           CardHuangli(baseColor: baseColor,
                       date: date)
            .padding(.vertical, 5.0)
            
            CardFoot(date: date, baseColor: baseColor)

        }
    }
}

struct CardBottom_Previews: PreviewProvider {
    static var previews: some View {
        CardBottom(date: Date(), baseColor: .green)
            .previewLayout(.sizeThatFits)
    }
}
