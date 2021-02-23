//
//  HeadBackView.swift
//  TodayExtension
//
//  Created by iOS on 2021/2/18.
//

import SwiftUI
import WidgetKit
struct SuitView: View {
    let date: Date
    var body: some View {
        HStack(alignment: .center) {
            Text("宜")
                .font(.caption)
                .padding(.all, 3.0)
                .overlay(
                    Circle().stroke(Color("green_color"), lineWidth: 2)
                )
            
            Text(SuitAvoid.suitAndAvoid(date: date, isSuit: true).joined(separator: " "))
                .font(.footnote)
                .lineLimit(1)
        }
    }
}

struct HeadBackView_Previews: PreviewProvider {
    static var previews: some View {
        SuitView(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
