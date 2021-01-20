//
//  CardBar.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/18.
//

import SwiftUI
struct CardBar: View {
    let baseColor: Color
    @State var isPresented = false
    
    var body: some View {
        HStack{
            Button(action: {
                NotificationCenter.default.post(Notification.init(name: Notification.Name.init("ReloadCard")))
            }) {
                Image("Today_Image")
            }
            .padding(20.0)
            .frame(width: 60.0, height: 50.0)
            
            Spacer()
            
            Text(/*@START_MENU_TOKEN@*/""/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: {
                isPresented.toggle()
            }) {
                Image("Calendar_Image")
            }
            .padding(20.0)
            .frame(width: 60.0, height: 50.0)
            .sheet(isPresented: $isPresented) {
                CalendarList()
            }
            
        }
        .frame(height: 50.0)
        .background(baseColor)
    }
    
}

struct CardBar_Previews: PreviewProvider {
    static var previews: some View {
        CardBar(baseColor: .green)
    }
}
