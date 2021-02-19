//
//  WeekView.swift
//  TodayExtension
//
//  Created by iOS on 2021/2/18.
//

import SwiftUI
import WidgetKit
struct WeekView: View {
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 2, alignment: .center), count: 7)) {
            ForEach(["一","二","三","四","五","六","日"], id: \.self) { string in
                Text(string)
                    .font(.system(size: 11))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(getColor(str: string))
            }
        }
        .padding(.horizontal, 5.0)
        .frame(height: 12.0)
    }
    
    func getColor(str: String) -> Color{
        switch str {
        case "六", "日":
           return Color("red_color_2")
        default:
            return Color("title_color")
        }
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
