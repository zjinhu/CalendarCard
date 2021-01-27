//
//  FootLeft.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct FootLeft: View {
    let date: Date
    let baseColor: Color
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(Constellation.calculateWithDate(date: date))
                    .font(.system(size: 16))
                    .foregroundColor(baseColor)
                Spacer()
            }
            .frame(height: 30.0)
            .background(Color("Bottom_Color"))
            
            ZStack{
                Text("\(date.getLunar().0) \(date.getLunar().1)")
                    .font(Font.system(size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(Color("Bottom_Color"))
            }
        }
        .background(baseColor)
        .border(baseColor, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
    }
}

struct FootLeft_Previews: PreviewProvider {
    static var previews: some View {
        FootLeft(date: Date(), baseColor: .green)
    }
}
