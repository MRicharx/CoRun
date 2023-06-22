//
//  SharedDifficulty.swift
//  CoRun
//
//  Created by Marselus Richard on 20/06/23.
//

import Foundation

///Class containing all Token saved in User Default
class SharedDifficulty{
    static let shared = SharedDifficulty()
    fileprivate init() { }
    
    let userDefaults = UserDefaults.standard
    
    var Distance: String {
        get {
            var result = "Normal"
            if let r = UserDefaults.standard.string(forKey: "Distance") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "Distance")
            UserDefaults.standard.synchronize()
        }
    }
    
    var Duration: String {
        get {
            var result = "Normal"
            if let r = UserDefaults.standard.string(forKey: "Duration") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "Duration")
            UserDefaults.standard.synchronize()
        }
    }
    
    var Pace: String {
        get {
            var result = "Normal"
            if let r = UserDefaults.standard.string(forKey: "Pace") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "Pace")
            UserDefaults.standard.synchronize()
        }
    }
    
    var Intensity: String {
        get {
            var result = "Normal"
            if let r = UserDefaults.standard.string(forKey: "Intensity") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "Intensity")
            UserDefaults.standard.synchronize()
        }
    }
}
