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
    var rkManager = RKManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365), mode: 0)
    
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
                self.isPresented = true
            }) {
                Image("Calendar_Image")
            }
            .padding(20.0)
            .frame(width: 60.0, height: 50.0)
            .sheet(isPresented: self.$isPresented, content: {
                    RKViewController(isPresented: self.$isPresented, rkManager: self.rkManager)
            })
            
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
