//
//  CardHuangli.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/22.
//

import SwiftUI

struct CardHuangli: View {
    let baseColor: Color
    let suitAndAvoid: ([String], [String])
    var body: some View {
        VStack{
            SuitItem(baseColor: baseColor, title: "宜", array: suitAndAvoid.0)
            SuitItem(baseColor: baseColor, title: "忌", array: suitAndAvoid.1)
        }
    }
}

struct CardHuangli_Previews: PreviewProvider {
    static var previews: some View {
        CardHuangli(baseColor: .green, suitAndAvoid: (["String"], ["String"]))
    }
}
