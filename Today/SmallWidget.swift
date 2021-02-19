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
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        +
                        Text("/\(date.getDateInfo().1)月")
                        .font(.system(size: 18))
                    
                    Spacer()
                    
                    Text("\(date.getWeekDayString())")
                        .font(.system(size: 16))
                        .padding(.top, 10.0)
                }
                .padding(.horizontal, 8.0)
                .frame(height: 46.0)
                .foregroundColor(.white)
                
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("red_color_1"), Color("red_color_2")]), startPoint: .top, endPoint: .bottom))

            Spacer()

            VStack(alignment: .leading, spacing: 2.0) {

                Text("\(date.getLunar().0)\(date.getLunar().1)")
                    .font(.system(size: 25))
                
                Spacer()
                
                SuitView(date: date)

                AvoidView(date: date)
                
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
