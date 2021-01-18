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

        CardStack(
          direction: FourDirections.direction,
          data: data,
          onSwipe: { index, direction in
            print("Swiped to \(index)--\(direction)")
          },
          content: { date, _, _ in
            let d = Item.stringConvertDate(string: date)
            if let info = Item.getDateInfo(date: d){
                CardItemView(info: info)
            }
          }
        )
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


