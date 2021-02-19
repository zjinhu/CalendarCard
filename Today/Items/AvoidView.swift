//
//  AvoidView.swift
//  TodayExtension
//
//  Created by iOS on 2021/2/18.
//

import SwiftUI
import WidgetKit
struct AvoidView: View {
    let date: Date
    var body: some View {
        HStack(alignment: .center) {
            Text("忌")
                .font(.caption)
                .padding(.all, 3.0)
                .overlay(
                    Circle().stroke(Color("red_color_2"), lineWidth: 2)
                )
            
            Text(SuitAvoid.suitAndAvoid(date: date, isSuit: false).joined(separator: " "))
                .font(.footnote)
                .lineLimit(1)
        }
    }
}

struct AvoidView_Previews: PreviewProvider {
    static var previews: some View {
        AvoidView(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
