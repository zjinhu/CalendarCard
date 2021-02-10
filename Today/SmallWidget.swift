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
        
        VStack{
            
            ZStack{
            
                HStack(alignment: .center){
                    
                    Text("\(date.getDateInfo().2)")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        +
                        Text("/\(date.getDateInfo().1)月")
                        .font(.system(size: 18))
                    
                    Spacer()
                    
                    Text("\(date.getWeekDayString())")
                        .font(.system(size: 16))
                        .padding(.top, 16.0)
                }
                .padding(.horizontal, 8.0)
                .frame(height: 50.0)
                .foregroundColor(.white)
                
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("top_color_1"), Color("top_color_2")]), startPoint: .top, endPoint: .bottom))

            Spacer()

            VStack(alignment: .leading, spacing: 2.0) {

                Text("\(date.getLunar().0)\(date.getLunar().1)")
                    .font(.system(size: 25))
                
                Spacer()
                
                HStack(alignment: .center) {
                    Text("宜")
                        .font(.caption)
                        .padding(.all, 3.0)
                        .overlay(
                            Circle().stroke(Color.green, lineWidth: 2)
                        )
                    
                    Text(SuitAvoid.suitAndAvoid(date: date, isSuit: true).joined(separator: " "))
                        .font(.footnote)
                        .lineLimit(1)
                }

                HStack(alignment: .center) {
                    Text("忌")
                        .font(.caption)
                        .padding(.all, 3.0)
                        .overlay(
                            Circle().stroke(Color.red, lineWidth: 2)
                        )
                    
                    Text(SuitAvoid.suitAndAvoid(date: date, isSuit: false).joined(separator: " "))
                        .font(.footnote)
                        .lineLimit(1)
                }
                Spacer()
            }
            .padding(.horizontal, 5.0)
            
            Spacer()
        }
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidget(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
