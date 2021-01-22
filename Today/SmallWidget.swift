//
//  SmallWidget.swift
//  TodayExtension
//
//  Created by iOS on 2021/1/22.
//

import SwiftUI
import WidgetKit
struct SmallWidget: View {
    let date: Date
    var body: some View {
  
            VStack(alignment: .leading, spacing: 2.0) {
                HStack(alignment: .bottom) {
                    Text("\(date.getDateInfo().2)").font(.system(size: 50)).fontWeight(.bold) + Text("/\(date.getDateInfo().1)月").font(.system(size: 11))
                }
                .foregroundColor(date.isWeekDay() ? .red : .green)

                Text("\(date.getLunar().0)\(date.getLunar().1)")
                    .font(.system(size: 25))
                    .foregroundColor(date.isWeekDay() ? .red : .green)
                
                HStack(alignment: .center) {
                    Text("宜")
                        .font(.caption)
                        .padding(.all, 3.0)
                        .overlay(
                            Circle().stroke(Color.green, lineWidth: 2)
                        )
                        .foregroundColor(date.isWeekDay() ? .red : .green)
                    Text(SuitAvoid.suitAndAvoid(month: date.getLunar().0, rizhi: SuitAvoid.getRiGanZhi(date: date)).0.joined(separator: " "))
                        .font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(date.isWeekDay() ? .red : .green)
                }
                HStack(alignment: .center) {
                    Text("忌")
                        .font(.caption)
                        .padding(.all, 3.0)
                        .overlay(
                            Circle().stroke(Color.red, lineWidth: 2)
                        )
                        .foregroundColor(date.isWeekDay() ? .red : .green)
                    Text(SuitAvoid.suitAndAvoid(month: date.getLunar().0, rizhi: SuitAvoid.getRiGanZhi(date: date)).1.joined(separator: " "))
                        .font(.footnote)
                        .lineLimit(1)
                        .foregroundColor(date.isWeekDay() ? .red : .green)
                }

            }
            .padding(.horizontal, 5.0)
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
