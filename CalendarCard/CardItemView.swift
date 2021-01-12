//
//  CardItemView.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/12.
//

import SwiftUI

struct CardItemView: View {
  let date: String

  var body: some View {
    GeometryReader { geo in
      VStack {
          Text("self.person.name \(date)")
          Spacer()
          Text("\(date) km away")
            .font(.footnote)
            .foregroundColor(.secondary)
            .frame(width: geo.size.width)
      }
      .background(Color.white)
      .cornerRadius(12)
      .shadow(radius: 4)
    }
  }
}

struct CardItemView_Previews: PreviewProvider {
    static var previews: some View {
        CardItemView(date: "2021-01-15")
    }
}

