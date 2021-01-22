//
//  SuitItem.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/22.
//

import SwiftUI

struct SuitItem: View {
    let baseColor: Color
    let title: String
    let array: [String]
    var body: some View {
        HStack{
            Text(title)
                .font(.title)
                .foregroundColor(baseColor)
            
            Text(":")
                .foregroundColor(baseColor)
            
            ForEach(array, id: \.self) { str in
                Text(str)
                    .foregroundColor(baseColor)
            }
            
            Spacer()
        }
        .padding(.horizontal, 10.0)
    }
}

struct SuitItem_Previews: PreviewProvider {
    static var previews: some View {
        SuitItem(baseColor: .green, title: "宜", array: ["123"])
    }
}
