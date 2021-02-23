//
//  CalendarCardApp.swift
//  CalendarCard
//
//  Created by iOS on 2021/2/23.
//

import SwiftUI
import SwiftMesh
@main
struct CalendarCardApp: App {
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate:NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Request.shared.getHoliday()
        return true
    }
}
