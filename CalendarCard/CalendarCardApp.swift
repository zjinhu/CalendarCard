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
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                NotificationHandler.shared.clearNotiBadges()
            case .background:
                print("Application is background")
            default:
                print("unexpected value.")
            }
        }
    }
}

class AppDelegate:NSObject,UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Request.shared.getHoliday()
        NotificationHandler.shared.registerForRemoteNotifications()
        return true
    }

}
