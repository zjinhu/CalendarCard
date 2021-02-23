//
//  DayView.swift
//  TodayExtension
//
//  Created by iOS on 2021/2/18.
//

import SwiftUI
import WidgetKit
struct DayView: View {
    @Environment(\.calendar) var calendar
    let date: Date
    let status: Int
    var body: some View {
        ZStack{
            VStack{
                
                Text("\(date.getDateInfo().2)")
                    .frame(width: 40, height: 24, alignment: .center)
                    .font(.system(size: 18))
                    .foregroundColor(getColor(color:date.isWeekDay() ? Color("red_color_2") : Color("title_color")))
                
                
                Text("\(LunarTool.getInfo(date: date))")
                    .font(.system(size: 11))
                    .foregroundColor(getColor(color:date.isWeekDay() ? Color("red_color_2") : Color("lunar_color")))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.bottom, 3.0)
            .overlay(
                RoundedRectangle(cornerRadius: 5).stroke(date.isToday() ? Color("red_color_2") : Color.clear, lineWidth: 2)
            )
            
            if status > 1 {
                VStack{
                    HStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .frame(width: 10.0, height: 10.0)
                                .foregroundColor(getColor(color:status > 2 ? Color("red_color_2") : Color("green_color")))
                            
                            Text(status > 2  ? "休" : "班")
                                .font(.system(size: 8))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.trailing, 5.0)
                    }
                    Spacer()
                }
            }
            
        }
        
    }
    
    func getColor(color: Color) -> Color{
        if calendar.isDate(date, equalTo: Date(), toGranularity: .month) {
            return color
        } else {
            return color.opacity(0.6)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(date: Date(), status: 1)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
//            .previewLayout(.fixed(width: 40, height: 30))
    }
}
