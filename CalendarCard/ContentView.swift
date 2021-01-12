//
//  ContentView.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/11.
//

import SwiftUI

struct ContentView: View {
    @State var data: [String] = Item.mock
    var body: some View {
        CardStack(
          direction: EightDirections.direction,
          data: data,
          onSwipe: { index, direction in
            print("Swiped to \(index)--\(direction)")
          },
          content: { date, _, _ in
            CardItemView(date: date)
          }
        )
        .padding(.all, 10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


