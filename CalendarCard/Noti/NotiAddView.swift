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

    @State var date: Date = Date()
    @State var time: Date = Date()

    @ObservedObject var titleLimit = TextBindingManager(limit: 20)
    @ObservedObject var infoLimit = TextBindingManager(limit: 100)
    
    var repeats = ["不重复", "每天", "每周", "每月", "每年"]
    @State private var selectedIndex = 0
    
    var body: some View {

        Form {
            Section {
                TextField("名称", text: $titleLimit.text)
                    
                ZStack(alignment: .topLeading) {
                    if infoLimit.text.isEmpty {
                        Text("备注")
                            .foregroundColor(Color.gray.opacity(0.5))
                            .padding(.top, 8)
                    }
                    TextEditor(text: $infoLimit.text)
                        .padding(.leading, -3)
                }
                .frame(height: 80.0)
            }

            Section {
                DatePicker(selection: $date, displayedComponents: .date) {
                    Text("日期")
                }
                
                DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                    Text("时间")
                }
            }
            
            Section {
                Picker(selection: $selectedIndex, label: Text("重复")) {
                    ForEach(0 ..< repeats.count) {
                        Text(repeats[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Button(action: {
                    addItem()
                }) {
                    Text("保存")
                }.disabled(isCanSave())
            }
        }
        .navigationBarTitle("添加提醒", displayMode: .inline)

    }
    
    func isCanSave() -> Bool{
        if titleLimit.text.isEmpty{
            return true
        }
        return false
    }
    
    private func addItem() {

        let newItem = Item(context: viewContext)
        newItem.time = time
        newItem.date = date
        newItem.title = titleLimit.text
        newItem.info = infoLimit.text
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
            
            guard let noti = Date(year: date.getYearNum(),
                                  month: date.getMonthNum(),
                                  day: date.getDayNum(),
                                  hour: time.getHourNum(),
                                  minute: time.getMinuteNum()) else {
                return
            }
            
            NotificationHandler.shared.calendarNoti(title: titleLimit.text,
                                                    body: infoLimit.text,
                                                    identifier: titleLimit.text,
                                                    date: noti,
                                                    repeats: 0)
        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


struct NotiAddView_Previews: PreviewProvider {
    static var previews: some View {
        NotiAddView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}


class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int

    init(limit: Int = 1){
        characterLimit = limit
    }
}


struct FilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .red : .white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(8)
    }
}
