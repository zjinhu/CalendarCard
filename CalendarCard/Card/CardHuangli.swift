//
//  CardHuangli.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/22.
//

import SwiftUI

struct CardHuangli: View {
    let baseColor: Color
    let date: Date
    var body: some View {
        VStack{
            SuitItem(baseColor: baseColor, title: "宜", array: SuitAvoid.suitAndAvoid(date: date, isSuit: true))
            SuitItem(baseColor: baseColor, title: "忌", array: SuitAvoid.suitAndAvoid(date: date, isSuit: false))
        }
    }
}

struct CardHuangli_Previews: PreviewProvider {
    static var previews: some View {
        CardHuangli(baseColor: .green, date: Date())
            .previewLayout(.sizeThatFits)
    }
}
