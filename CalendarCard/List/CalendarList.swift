//
//  CalendarList.swift
//  CalendarCard
//
//  Created by iOS on 2021/1/15.
//

import SwiftUI

struct CalendarList: View {
    
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        Button(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                })
    }
}

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}
