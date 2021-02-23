//
//  CardHoliday.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CardHoliday: View {

    let baseColor: Color
    let date : Date
    let holiday: Holiday?
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    if let h = holiday {
                        Text(h.name ?? "")
                            .font(Font.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(baseColor)
                    }else{
                        if let jieri = LunarTool.getJieRi(date: date) {
                            Text(jieri)
                                .font(Font.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(baseColor)
                        }
                    }
                }
                .padding(.vertical, 5.0)
                Spacer()
            }
            VStack{
                Spacer()
                Text(LunarTool.getDay(date: date))
                    .font(Font.system(size: 200))
                    .fontWeight(.bold)
                    .foregroundColor(baseColor)
            }
            
            if let h = holiday {
                VStack{
                    HStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(h.holiday ? Color("Red_Color") : Color("Green_Color"))
                            
                            Text(h.holiday ? "休" : "班")
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
        .frame(width: 270.0, height: 240.0)
    }
}

struct CardHoliday_Previews: PreviewProvider {
    static var previews: some View {
        CardHoliday(baseColor: .green,
                    date: Date(),
                    holiday: Holiday())
            .previewLayout(.sizeThatFits)
    }
}
