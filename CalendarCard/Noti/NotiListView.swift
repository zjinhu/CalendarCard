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
                
                VStack(alignment: .leading){
                    
                    Text("\(item.title ?? "")")
                        .font(.title)
                    Text("\(item.info ?? "")")
                        .font(.body)
                    
                    Divider()
                        .padding(.horizontal, 20.0)
                    
                    HStack{
                        Text("\(item.date?.getNotiDate() ?? "")")
                            .font(.body)
                            .fontWeight(.medium)
                        Text("\(item.time?.getNotiTime() ?? "")")
                            .font(.body)
                    }
                }
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.purple/*@END_MENU_TOKEN@*/)
                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                
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
        NotiListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
