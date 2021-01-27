//
//  CardItem.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CardItem: View {
    
    init(date: Date, holiday: Holiday?) {
        current = date
        currentHoliday = holiday
        
        if LunarTool.isWeekEnd(date: date) {
            status = 1
        }else{
            status = 0
        }
        
        if let h = holiday {
            if h.holiday == true {
                status = 3
            }else{
                status = 2
            }
        }
    }
    
    var current: Date?
    var currentHoliday: Holiday?
    
    var status: Int = 0
    
    var body: some View {
        
        ZStack{
            VStack {
                
                CardBar(baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"))
                
                CardHead(date: current!,
                         baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"))
                    .padding([.top, .leading, .trailing])
                
                Spacer()
                
                CardHoliday(baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"),
                            date: current!,
                            holiday: currentHoliday)
                Spacer()
                
                CardBottom(date: current!,
                           baseColor: status == 1||status == 3 ? Color("Red_Color") : Color("Green_Color"))
                    .padding([.leading, .trailing], 10.0)
                    .padding([.bottom], 20.0)
            }
            
        }
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(date: Date(), holiday: Holiday())
    }
}
