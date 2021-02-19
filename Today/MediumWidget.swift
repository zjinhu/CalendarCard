//
//  MediumWidget.swift
//  TodayExtension
//
//  Created by iOS on 2021/1/22.
//

import SwiftUI
import WidgetKit
struct MediumWidget: View {
    let date: Date
    var body: some View {
        VStack(spacing: 8.0){
            
            ZStack{
            
                HStack(alignment: .center){
                    
                    Text("\(date.toYearString())")
                        .font(.system(size: 18))
                    
                    Spacer()
                    
                    Text("\(date.getLunar().0)\(date.getLunar().1)")
                        .font(.system(size: 20))
                }
                .padding(.horizontal, 16.0)
                .frame(height: 46.0)
                .foregroundColor(.white)
                
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("red_color_1"), Color("red_color_2")]), startPoint: .top, endPoint: .bottom))

            WeekView()
            WeekDaysView(days: date.getWeekDays())
            
            HStack() {
                SuitView(date: date).frame(maxWidth: .infinity)
                AvoidView(date: date).frame(maxWidth: .infinity)
            }
            .padding([.leading, .trailing], 12.0)
            Spacer()
        }
    }
}

struct MediumWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidget(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
