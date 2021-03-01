//
//  NotiListView.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/20.
//

import SwiftUI
import CoreData
struct NotiListView: View {
    @Environment(\.presentationMode) var mode
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    
    var body: some View {
        NavigationView {
            
            EmptyList(items) { item in
                VStack{
                    NotiListCell(title: item.title,
                                 info: item.info,
                                 date: item.date,
                                 time: item.time)
                }
                .padding(/*@START_MENU_TOKEN@*/.vertical, 5.0/*@END_MENU_TOKEN@*/)
                .padding(.horizontal, 10.0)
                .background(Color(.systemBackground))
                .listRowInsets(EdgeInsets(top: -1, leading: -1, bottom: -1, trailing: -1))
                
                
            } emptyListView: {
                
                VStack{
                    Image("s2")
                    Text("当前列表为空")
                }
                
            } onDelete: { index in
                deleteItems(offsets: index)
            }
            .navigationBarTitle("提醒", displayMode: .inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.mode.wrappedValue.dismiss()
                                    }) {
                                        Image(systemName: "arrow.uturn.backward")
                                    },
                                trailing:
                                    NavigationLink(destination:
                                        NotiAddView()
                                    ){
                                        Image(systemName: "plus")
                                    }
            )
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NotiListView_Previews: PreviewProvider {
    static var previews: some View {
        NotiListView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
