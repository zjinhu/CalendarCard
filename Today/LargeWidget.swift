//
//  LargeWidget.swift
//  TodayExtension
//
//  Created by iOS on 2021/1/22.
//

import SwiftUI
import WidgetKit
struct LargeWidget: View {
    let date: Date
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
