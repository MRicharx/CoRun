//
//  AppDelegate.swift
//  CoRun
//
//  Created by Marselus Richard on 15/05/23.
//

import UserNotifications
import UIKit
import SwiftUI
import BackgroundTasks

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, ObservableObject {
    @Published var deviceToken: Data?
//    let taskIdentifier = "com.mricharx.ckdemo.CoRun.syn"
    let notification = HNotification()
    
    ///Handle launching app with option key
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                application.registerForRemoteNotifications()
            } else {
                // Handle authorization denied case
                print("Authorization for remote notifications denied.")
            }
        }
        
        return true
    }
    
    ///Handle register device remote notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        SharedToken.shared.NotificationToken = deviceTokenString
        }
    ///Handle register remote notification failure
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(">> Device failed register remote notification: \(error.localizedDescription)")
    }
    
    ///Trigger background function for synchronize session data
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(">> BG Running")
        
        let bg = HBackground()
        let userInfo = response.notification.request.content.userInfo
        
        if let functionIdentifier = userInfo["functionIdentifier"] as? String {
            if functionIdentifier == "SynchronizeWorkout" {
                // Execute the corresponding function
                bg.syncWorkout{
                    completionHandler()
                }
            }
        }
    }
    
    func scheduleAppRefresh() {
//        let request = BGAppRefreshTaskRequest(identifier: taskIdentifier)
//        request.earliestBeginDate = Date(timeIntervalSinceNow: 1800)
//
//        do {
//            try BGTaskScheduler.shared.submit(request)
//        } catch {
//            print("Couldn't schedule app refresh \(error.localizedDescription)")
//        }
        //MARK: Refresh app if neccessary
    }
}

