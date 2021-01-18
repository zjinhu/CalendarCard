//
//  CardHoliday.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CardHoliday: View {

    let holiday: Holiday?
    let baseColor: Color
    let day : String
    
    var body: some View {
        ZStack{
            Text(day)
                .font(Font.system(size: 200))
                .fontWeight(.bold)
                .foregroundColor(baseColor)
            
            if let h = holiday{
                VStack{
                    HStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(h.holiday ?? false ? .green : .red)
                                
                            Text(h.holiday ?? false ? "休" : "班")
                                .font(.system(size: 30))
                                .fontWeight(.medium)
                                .padding(.all, 20.0)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Spacer()
                }
            }
            
            
        }
        .frame(width: 270.0, height: 270.0)
    }
}

struct CardHoliday_Previews: PreviewProvider {
    static var previews: some View {
        CardHoliday(holiday: Holiday(), baseColor: .green, day: "20")
    }
}
