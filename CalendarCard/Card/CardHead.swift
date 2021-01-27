//
//  CardHead.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct CardHead: View {
    let date: Date
    let baseColor: Color
    var body: some View {
        HStack{
            Text("\(date.getDateInfo().0)")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading, 10.0)
                .foregroundColor(baseColor)
            Spacer()
            Text(LunarTool.getMonth(index: date.getDateInfo().1))
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(baseColor)
            Spacer()
            Text("\(date.getDateInfo().1)月")
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
    }
}

struct CardHead_Previews: PreviewProvider {
    static var previews: some View {
        CardHead(date: Date(), baseColor: .green)
    }
}
