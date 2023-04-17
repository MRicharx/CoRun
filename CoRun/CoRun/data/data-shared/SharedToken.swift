//
//  SharedToken.swift
//  CoRun
//
//  Created by Marselus Richard on 15/04/23.
//

import Foundation

///Class containing all Token saved in User Default
class SharedToken{
    static let shared = SharedToken()
    fileprivate init() { }
    
    let userDefaults = UserDefaults.standard
    
    var SignInToken: String {
        get {
            var result = ""
            if let r = UserDefaults.standard.string(forKey: "SignInToken") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "SignInToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    var NotificationToken: String {
        get {
            var result = ""
            if let r = UserDefaults.standard.string(forKey: "NotificationToken") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "NotificationToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    var RefreshToken: String {
        get {
            var result = ""
            if let r = UserDefaults.standard.string(forKey: "RefreshToken") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "RefreshToken")
            UserDefaults.standard.synchronize()
        }
    }
}
