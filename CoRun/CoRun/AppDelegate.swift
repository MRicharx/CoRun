//
//  AppDelegate.swift
//  CoRun
//
//  Created by Marselus Richard on 15/05/23.
//

import UserNotifications
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        // Other app launch configurations
        
        return true
    }
    
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
}

