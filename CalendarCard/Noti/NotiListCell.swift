//
//  NotiListCell.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/24.
//

import SwiftUI
import CoreData

struct NotiListCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    let item: Item
    var body: some View {
        VStack(alignment: .leading){
            
            Text("\(item.title ?? "")")
            Text("\(item.info ?? "")")
            
            HStack{
                Text("\(item.date?.getNotiDate() ?? "")")
                Text("\(item.time?.getNotiTime() ?? "")")
            }
        }
        
    }
}

struct NotiListCell_Previews: PreviewProvider {
    static var previews: some View {
        NotiListCell(item: Item())
            .previewLayout(.sizeThatFits)
    }
}
