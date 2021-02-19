//
//  CalendarCardApp.swift
//  CalendarCard
//
//  Created by 狄烨 . on 2021/1/11.
//

import SwiftUI
import SwiftMesh
@main
struct CalendarCardApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate:NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Request.shared.getHoliday()
        return true
    }
}
