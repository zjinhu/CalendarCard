//
//  NotiAddView.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/23.
//

import SwiftUI
import CoreData
import ToastUI

struct NotiAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State var date: Date = Date()
    @State var time: Date = Date()

    @State private var showToast = false
    
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
                        Text(self.repeats[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Button(action: {
                    addItem()
                }) {
                    Text("保存")
                }
            }
        }
        .toast(isPresented: $showToast, dismissAfter: 2.0) {
            VStack {
                Text("请填写新提醒名称")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 200.0, height: 50.0)
            .background(Color.black)
            .cornerRadius(8.0)
        }
        .navigationBarTitle("添加提醒", displayMode: .inline)

    }
    
    private func addItem() {

        if titleLimit.text.isEmpty{
            showToast.toggle()
            return
        }

        let newItem = Item(context: viewContext)
        newItem.time = time
        newItem.date = date
        newItem.title = titleLimit.text
        newItem.info = infoLimit.text
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}


struct NotiAddView_Previews: PreviewProvider {
    static var previews: some View {
        NotiAddView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
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
