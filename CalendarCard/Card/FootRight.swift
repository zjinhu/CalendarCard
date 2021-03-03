//
//  FootRight.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct FootRight: View {
    let date: Date
    let baseColor: Color
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(LunarTool.getWeekEng(week: date.getWeekNum()))
                    .font(.system(size: 16))
                    .foregroundColor(baseColor)
                Spacer()
            }
            .frame(height: 30.0)
            .background(Color("Bottom_Color"))
            
            Text(LunarTool.getWeekChn(week: date.getWeekNum()))
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
        FootRight(date: Date(), baseColor: .green)
            .previewLayout(.sizeThatFits)
    }
}
