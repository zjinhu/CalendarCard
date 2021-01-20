//
//  ContentView.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/11.
//

import SwiftUI

struct ContentView: View {
    @State var data: [String] = Item.loadDate()
    var body: some View {
        ZStack{
            
            Button(action: {
                NotificationCenter.default.post(Notification.init(name: Notification.Name.init("ReloadCard")))
            }){
                Text("到最后一天了么?");
            }
            .font(.title)
            .padding(.horizontal, 50.0)
            .background(Color.orange)
            .foregroundColor(Color.white)
            .cornerRadius(50).padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 50).stroke(Color.orange, lineWidth: 5)
            )
            
            CardStack(
                direction: FourDirections.direction,
                data: data,
                onSwipe: { index, direction in
                    print("Swiped to \(index)--\(direction)")
                },
                content: { date, _, _ in
                    let d = Item.stringConvertDate(string: date)
                    
                    let holiday = Request.shared.getInfo(d.getHolidayKey())

                    if let info = Item.getDateInfo(date: d){
                        CardItemView(info: info, holiday: holiday)
                    }
                }
            )

        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


