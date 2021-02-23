//
//  NotiAddView.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/23.
//

import SwiftUI
import CoreData

struct NotiAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var info: String = ""
    @State var date: Date = Date()
    @State var time: Date = Date()
    
    var body: some View {
        
        Form {
            Section(header: Text("PROFILE")) {
                TextField("Title", text: $title)
                TextField("Info", text: $info)
            }

            Section {

                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
                
                DatePicker(selection: $time, in: ...Date(), displayedComponents: .hourAndMinute) {
                    Text("Select a date")
                }
            }
            
            Section {
                Button(action: {
                    addItem()
                }) {
                    Text("Reset All Settings")
                }
                
            }
        }
    }
    
    private func addItem() {

        let newItem = Item(context: viewContext)
        newItem.time = time
        newItem.date = date
        newItem.title = title
        newItem.info = info
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


struct NotiAddView_Previews: PreviewProvider {
    static var previews: some View {
        NotiAddView()
    }
}
