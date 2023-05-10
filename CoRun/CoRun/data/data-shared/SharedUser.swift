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
    
    var UserData: ProfileData {
        get {
            if let data = UserDefaults.standard.data(forKey: "ProfileData"){
                do {
                    // Create JSON Decoder
                    let decoder = JSONDecoder()
                    // Decode Note
                    let result = try decoder.decode(ProfileData.self, from: data)
                    print(">> de JSON: \(data)")
                    
                    return result
                } catch {
                    print("Unable to Decode Note (\(error))")
                }
            }
            return ProfileData()
        }
        
        set(_data) {
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()
                // Encode Note
                let data = try encoder.encode(_data)
                print(">> e JSON: \(data)")
                
                // Write Data
                UserDefaults.standard.set(data, forKey: "ProfileData")
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
