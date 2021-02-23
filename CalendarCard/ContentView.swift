//
//  ContentView.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/23.
//

import SwiftUI


struct ContentView: View {
    @State var data: [String] = LunarTool.loadDate()
    var body: some View {
        ZStack{
            
            Button(action: {
                NotificationCenter.default.post(name: NSNotification.Name.init(CardNotification), object: Date().todayCount())
            }){
                Text("回到今天")
            }
            .frame(height: 80.0)
            .font(.title)
            .padding(.horizontal, 50.0)
            .background(Color("Green_Color"))
            .foregroundColor(Color.white)
            .clipShape(Capsule())
            
            CardStack(index: Date().todayCount(), data: data){ date in
                let d = LunarTool.stringConvertDate(string: date)
                let holiday = Request.shared.getInfo(d.getHolidayKey())

                GeometryReader { geo in
                    CardItem(date: d, holiday: holiday)
                }
                .background(Color("BG_Color"))
                .cornerRadius(12)
                .shadow(radius: 4)
                
            }
            .padding([.top, .leading, .trailing], 10.0)
            .padding(/*@START_MENU_TOKEN@*/.bottom, 20.0/*@END_MENU_TOKEN@*/)
    
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
