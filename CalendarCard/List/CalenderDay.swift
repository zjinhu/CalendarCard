//
//  CalenderDay.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/20.
//

import SwiftUI

struct CalenderDay: View {
    
    let day: String
    let lunar: String
    let status: Int
    let isToday: Bool
    
    var body: some View {
        ZStack{
            VStack{
                
                Text(day)
                    .frame(width: 40, height: 40, alignment: .center)
                    .font(.title)
                    .foregroundColor(status > 0 ? Color("Red_Color") : Color("Day_Color"))
                
                
                Text(lunar)
                    .font(.footnote)
                    .foregroundColor(status > 0 ? Color("Red_Color") : .gray)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.bottom, 5.0)
            .overlay(
                RoundedRectangle(cornerRadius: 5).stroke( isToday ? Color.orange : Color.clear, lineWidth: 2)
            )
            
            if status > 1 {
                VStack{
                    HStack{
                        Spacer()
                        ZStack{
                            Circle()
                                .frame(width: 15.0, height: 15.0)
                                .foregroundColor(status > 2 ? Color("Red_Color") : Color("Green_Color"))
                            
                            Text(status > 2  ? "休" : "班")
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .padding(.all, 2.0)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        }
                    }
                    Spacer()
                }
            }
            
        }
        
    }
    
}

struct CalenderDay_Previews: PreviewProvider {
    static var previews: some View {
        CalenderDay(day: "15", lunar: "腊八腊八", status: 4, isToday: true)
            .previewLayout(.fixed(width: 60, height: 80))
    }
}
