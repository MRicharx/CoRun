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
                self.permissionStatus = .yetAsked
            } else if settings.authorizationStatus == .denied {
                self.permissionStatus = .denied
            } else if settings.authorizationStatus == .authorized {
                self.permissionStatus = .granted
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
    
    ///Schedule sync daily task
    func scheduleTask(){
        let center = UNUserNotificationCenter.current()
        ///Ger notification permission status
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            ///Check if permission granted
            if granted {
                ///Get pending notification, check if scheduled task exist
                center.getPendingNotificationRequests { requests in
                    let isTaskScheduled = requests.contains { request in
                        return request.identifier == "BackgroundTask"
                    }
                    
//                    let isTaskScheduled = false
                    
                    ///If task yet scheduled, schedule the task
                    if !isTaskScheduled{
                        let content = UNMutableNotificationContent()
                        content.title = "Synchronizing Your Workout"
                        content.body = "Updating you training plan"
                        
                        // Set the time for your background task (e.g., 23:59)
                        var dateComponents = DateComponents()
                        dateComponents.hour = 23
                        dateComponents.minute = 59
                        
                        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                        
                        // Pass the function identifier in the userInfo dictionary
                        let userInfo = ["functionIdentifier": "SynchronizeWorkout"]
                        content.userInfo = userInfo
                        
                        let request = UNNotificationRequest(identifier: "BackgroundTask", content: content, trigger: trigger)
                        
                        center.add(request) { error in
                            if let error = error {
                                print(">> Error scheduling background task: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            } else if let error = error {
                print(">> Error requesting authorization for notifications: \(error.localizedDescription)")
            }
        }
    }
    
    ///Schedule daily reminder
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
        let request = UNNotificationRequest(identifier: "DailyReminder", content: content, trigger: trigger)

        // Clear and add our notification request
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().add(request)
        print(">> HNotification: Schedule Notification at \(dateInfo.hour ?? 99):\(dateInfo.minute ?? 99)")
    }
    
    func clearScheduledNotification(){
        let center = UNUserNotificationCenter.current()
        
//        center.removeAllPendingNotificationRequests()
        center.removePendingNotificationRequests(withIdentifiers: ["DailyReminder"])
        
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
    
    func pushDummyNotification(message:String){
        
        let content = UNMutableNotificationContent()
        content.title = "Dummy"
        content.subtitle = message
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: "Dummy", content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

enum notificationPermissionResponse{
    case yetAsked
    case denied
    case granted
}
