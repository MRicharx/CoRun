//
//  SharedUser.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation

///Class containing user date saved in User Default
class SharedUser{
    static let shared = SharedUser()
    fileprivate init() { }
    
    let userDefaults = UserDefaults.standard
    
    var UserData: CoreUser {
        get {
            if let data = UserDefaults.standard.data(forKey: "UserData"){
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()
                    // Decode Note
                    let result = try decoder.decode(CoreUser.self, from: data)
                    
                    return result
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
            
            return CoreUser()
        }
        
        set(_data) {
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()
                // Encode Note
                let data = try encoder.encode(_data)
                // Write Data
                UserDefaults.standard.set(data, forKey: "UserData")
                UserDefaults.standard.synchronize()
            } catch {
                print("Unable to Encode Note (\(error))")
            }
//
//            UserDefaults.standard.setValue(_data, forKey: "UserData")
//            //UserDefaults.standard.set(_data, forKey: "UserData")
//            UserDefaults.standard.synchronize()
        }
    }
}
