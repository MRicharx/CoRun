//
//  SharedReminder.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation

///Class containing reminder value saved in User Default
class SharedReminder{
    static let shared = SharedReminder()
    fileprivate init() { }
    
    let userDefaults = UserDefaults.standard
    
    var isReminderActive: Bool {
        get {
            var result = true
            if let r = UserDefaults.standard.bool(forKey: "isReminderActive") as Bool? {
                result = r
            }
            return result
        }
        
        set(_value) {
            UserDefaults.standard.set(_value, forKey: "isReminderActive")
            UserDefaults.standard.synchronize()
        }
    }
    
    var ReminderValue: Date {
        get {
            var result = Calendar.current.date(bySettingHour: 7, minute: 00, second: 0, of: Date())!
            if let r = UserDefaults.standard.object(forKey: "ReminderValue") {
                result = r as! Date
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "ReminderValue")
            UserDefaults.standard.synchronize()
        }
    }
}
