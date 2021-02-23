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
        VStack(spacing: 10.0){
            
            ZStack{
            
                HStack(alignment: .center){
                    
                    Text("\(date.toYearString())")
                        .font(.system(size: 18))
                    
                    Spacer()
                    
                    Text("\(date.getLunar().0)\(date.getLunar().1)")
                        .font(.system(size: 20))
                }
                .padding(.horizontal, 16.0)
                .frame(height: 50.0)
                .foregroundColor(.white)
                
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color("red_color_1"), Color("red_color_2")]), startPoint: .top, endPoint: .bottom))

            WeekView()
            
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 2, alignment: .center), count: 7), spacing: 2) {
                
                ForEach(date.getMonthDays(), id: \.self) { date in
                    DayView(date: date, status: LunarTool.getHoliday(date: date))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 5.0)
            
            Spacer()
        }
    }
}

struct LargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        LargeWidget(date: Date())
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
