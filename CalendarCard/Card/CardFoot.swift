//
//  CardFoot.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/14.
//

import SwiftUI

struct CardFoot: View {
    let date: Date
    let baseColor: Color
    var body: some View {
        HStack{
            FootLeft(date: date, baseColor: baseColor)
            Spacer()
            FootRight(date: date, baseColor: baseColor)
        }
    }
}

struct CardFoot_Previews: PreviewProvider {
    static var previews: some View {
        CardFoot(date: Date(), baseColor: .green)
            .previewLayout(.sizeThatFits)
    }
}
