//
//  HNotification.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation
import UserNotifications

class HNotification:ObservableObject{
    @Published var permissionStatus = notificationPermissionResponse.yetAsked
    
    init(){
        refreshPermission()
    }
    
    func refreshPermission(){
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                // Notification permission has not been asked
                self.permissionStatus = .yetAsked
//                print(">> HNotification: Asking Permission")
            } else if settings.authorizationStatus == .denied {
                // Notification permission was previously denied, go to settings & privacy to re-enable
                self.permissionStatus = .denied
//                print(">> HNotification: Permission DENIED")
            } else if settings.authorizationStatus == .authorized {
                // Notification permission was already granted
                self.permissionStatus = .granted
//                print(">> HNotification: Permission GRANTED")

            }
        })
    }
    func requestPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
            } else if let error = error {
                print(error.localizedDescription)
            }
            self.refreshPermission()
        }
    }
    
    func scheduleNotification(time: Date){
        let content = UNMutableNotificationContent()
        content.title = "You can do it!!"
        content.subtitle = "Don't forget to train today as well"
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        
        //Receive with date
            var dateInfo = DateComponents()
        dateInfo.hour = calendar.component(.hour, from: time) //Put your hour
        dateInfo.minute = calendar.component(.minute, from: time) //Put your minutes
        
        // show this notification five seconds from now
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Clear and add our notification request
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().add(request)
        print(">> HNotification: Schedule Notification at \(dateInfo.hour ?? 99):\(dateInfo.minute ?? 99)")
    }
    
    func clearScheduledNotification(){
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        
        print(">> HNotification: Scheduled Notification Cleared")
    }
    
    func scheduleDummyNotification(){
        let center = UNUserNotificationCenter.current()
//        center.removeAllPendingNotificationRequests()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 00
        dateComponents.minute = 15
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Title goes here"
        content.body = "Main text goes here"
        content.categoryIdentifier = "customIdentifier"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
    }
    
    func pushDummyNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "You can do it"
        content.subtitle = "Keep your best fo today training as well"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        print(">> HNotification: Dummy Notification sent")
    }
}

enum notificationPermissionResponse{
    case yetAsked
    case denied
    case granted
}
