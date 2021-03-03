//
//  NotificationHandler.swift
//  CalendarCard
//
//  Created by iOS on 2021/3/2.
//
import UIKit
import Foundation
import UserNotifications

class NotificationHandler: NSObject{
    
    static let shared = NotificationHandler()
    
    func clearNotiBadges(){
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func registerForRemoteNotifications(){
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized:
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
                    if granted {
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            default:
                break
            }
        }
    }
}

extension NotificationHandler: UNUserNotificationCenterDelegate{
    
    //在应用内展示通知//如果当通知到达的时候，你的应用已经在运行
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.list,.sound,.badge,.banner])
        // 如果不想显示某个通知，可以直接用空 options 调用 completionHandler:
        // completionHandler([])
    }
    ///通知点击后进入这里
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        AlertOneVC.alert(title: response.notification.request.content.title,
//                         message: response.notification.request.content.body,
//                         btnTitle: "好的") {
//            if response.notification.request.content.title == "烂笔头提醒" {
//                if let _ = SwiftMediator.shared.currentViewController() as? RecordVC{
//
//                }else{
//                    SwiftMediator.shared.push("RecordVC")
//                }
//            }
//        }
        completionHandler()
    }
    
}

extension NotificationHandler {
    
    /// 添加推送
    /// - Parameter identifier: 推送标识符
    /// - Parameter content: UNMutableNotificationContent
    /// - Parameter trigger: UNNotificationTrigger
    func registerPushNotiWithIdentifier(identifier: String, content: UNMutableNotificationContent, trigger: UNNotificationTrigger){
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
//            log.debug("\(String(describing: error))")
        }
    }
    
    func getAllPendingNoti(callback: @escaping ([String]) -> Void){
        
        var array: [String] = []
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            requests.forEach { (requ) in
                array.append(requ.identifier)
            }
            callback(array)
        }

    }
    
    /// 删除指定标识符的未发出的推送
    /// - Parameter identifier: 推送标识符
    func removePendingNotiWithIdentifier(identifier: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    /// 删除所有未发出的推送
    func removeAllPendingNoti(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    /// 普通推送--文字
    /// - Parameter title: 推送主标题
    /// - Parameter subTitle: 推送副标题
    /// - Parameter body: 推送内容体
    /// - Parameter userInfo: 推送附带字典,默认为空
    /// - Parameter identifier: 推送标识符
    /// - Parameter timeInterval: 推送间隔时间
    /// - Parameter repeat: 是否重复,若要重复->时间间隔应>=60s
    func timeNoti(title: String,
                  body: String,
                  identifier: String,
                  soundName: String? = nil,
                  timeInterval: TimeInterval,
                  repeats: Bool){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = 1
        
        if let sn = soundName{
            let sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(sn).mp3"))
            content.sound = sound
        }else{
            content.sound = UNNotificationSound.default
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        
        registerPushNotiWithIdentifier(identifier: identifier, content: content, trigger: trigger)
    }
    
    
    func calendarNoti(title: String,
                      body: String,
                      identifier: String,
                      soundName: String? = nil,
                      date: Date,
                      repeats: Int){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.badge = 1
        
        if let sn = soundName{
            let sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "\(sn).mp3"))
            content.sound = sound
        }else{
            content.sound = UNNotificationSound.default
        }
        
        var dateComponents = DateComponents()
        var isRepeat = false
        switch repeats {

        case 1:
            isRepeat = true
            dateComponents = Calendar.current.dateComponents([.year,.day,.month,.hour,.minute,.second], from: date)
            dateComponents.weekday = date.getWeekNum()
        case 2:
            isRepeat = true
            dateComponents = Calendar.current.dateComponents([.year,.day,.month,.hour,.minute,.second], from: date)
            dateComponents.day = date.getDayNum()
        case 3:
            isRepeat = true
            dateComponents = Calendar.current.dateComponents([.year,.day,.month,.hour,.minute,.second], from: date)
            dateComponents.month = date.getMonthNum()
            dateComponents.day = date.getDayNum()
        default:
            isRepeat = false
            dateComponents = Calendar.current.dateComponents([.year,.day,.month,.hour,.minute,.second], from: date)
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isRepeat)
        
        registerPushNotiWithIdentifier(identifier: identifier, content: content, trigger: trigger)
    }
    
}
