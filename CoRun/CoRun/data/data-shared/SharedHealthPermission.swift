//
//  SharedToken.swift
//  CoRun
//
//  Created by Marselus Richard on 15/04/23.
//

import Foundation

///Class containing all Token saved in User Default
class SharedHealthPermission{
    static let shared = SharedHealthPermission()
    fileprivate init() { }
    
    let userDefaults = UserDefaults.standard
    
    var ishealthPermissionAsked: String {
        get {
            var result = ""
            if let r = UserDefaults.standard.string(forKey: "Health") as String? {
                result = r
            }
            return result
        }
        
        set(_token) {
            UserDefaults.standard.set(_token, forKey: "Health")
            UserDefaults.standard.synchronize()
        }
    }
}
