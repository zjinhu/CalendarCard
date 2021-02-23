//
//  NotiListView.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/20.
//

import SwiftUI
import CoreData
struct NotiListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    
    var body: some View {
        NavigationView {
            
            EmptyList(items) { item in
                Text("Item at \(item.time!, formatter: itemFormatter)")
            } emptyListView: {
                
                VStack{
                    Image("s2")
                    Text("当前列表为空")
                }
                
            } onDelete: { index in
                deleteItems(offsets: index)
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination:
                NotiAddView()){
                Text("Add")
            })

//            List {
//                ForEach(items) { item in
//                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                }
//                .onDelete(perform: deleteItems)
//            }

        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NotiListView_Previews: PreviewProvider {
    static var previews: some View {
        NotiListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
