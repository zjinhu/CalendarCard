//
//  NotiListCell.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/26.
//

import SwiftUI

struct NotiListCell: View {
    let title: String?
    let info: String?
    let date: Date?
    let time: Date?
    var body: some View {
        VStack(alignment: .leading){
            
            Text(title ?? "")
                .font(.title)
                .padding([.top, .trailing], 10.0)
                .padding(/*@START_MENU_TOKEN@*/.leading, 20.0/*@END_MENU_TOKEN@*/)
            
            Text(info ?? "")
                .font(.body)
                .padding(.trailing, 20.0)
                .padding(/*@START_MENU_TOKEN@*/.leading, 20.0/*@END_MENU_TOKEN@*/)
                .padding(/*@START_MENU_TOKEN@*/.top, 5.0/*@END_MENU_TOKEN@*/)
            
            Divider()
                .padding(.horizontal, 20.0)
            
            HStack(alignment: .center){
                
                Text("\(date?.getNotiDate() ?? "")")
                    .font(.body)
                    .fontWeight(.medium)
                    .padding(.leading, 20.0)
                
                Text("\(time?.getNotiTime() ?? "")")
                    .font(.body)
                    .padding(.leading, 10.0)
            }
            .padding(.bottom, 10.0)
            .frame(height: 30.0)
        }
        .background(Color(.tertiarySystemGroupedBackground))
        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
    }
}

struct NotiListCell_Previews: PreviewProvider {
    static var previews: some View {
        NotiListCell(title: "hahah", info: "dfsgsdfg", date: Date(), time: Date())
            .previewLayout(.sizeThatFits)
    }
}
