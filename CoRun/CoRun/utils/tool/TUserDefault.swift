//
//  TUserDefault.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation

///TUserDefault - User Default Tool
///This Protocol contain list of func to help using data from userdefault
protocol TUserDefaultProtocol{
    ///Write string data to user default
    func write(string:String,key:String)
    ///Write int data to user default
    func write(int:Int,key:String)
    ///Write double data to user default
    func write(double:Double,key:String)
    ///Write object data to user default
    func write(obj:String,key:String)
    ///Write bool data to user default
    func write(bool:Bool, key:String)
    
    ///Return int data from user default
    func readInt(key:String)->Int
    ///Return int data from user default
    func readDouble(key:String)->Double
    ///Return int data from user default
    func readString(key:String)->String
    ///Return int data from user default
    func readBool(key:String)->Bool
    ///Return object data from user default
    func readObj(key:String)->Any
    
    ///Remove an object from user default
    func remove(key:String)
    ///Remove all existing user default
    func removeAll()
}
///This class define function declared at TUserDefaultProtocol
class TUserDefault:TUserDefaultProtocol{
    ///This struct contain list of key that used
    struct KeyList{
        let Token = "token"
        
    }
    
    func write(int: Int, key: String) {
        UserDefaults.standard.set(int, forKey: key)
    }
    func write(double: Double, key: String) {
        UserDefaults.standard.set(double, forKey: key)
    }
    func write(bool: Bool, key: String) {
        UserDefaults.standard.set(bool, forKey: key)
    }
    func write(string: String, key: String) {
        UserDefaults.standard.set(string, forKey: key)
    }
    func write(obj: String, key: String) {
        UserDefaults.standard.set(obj, forKey: key)
    }
    
    func readInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    func readDouble(key: String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    func readBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    func readString(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    func readObj(key: String) -> Any {
        return UserDefaults.standard.object(forKey: key)
    }
    
    func remove(key: String) {
        UserDefaults.standard.removeObject(forKey: "Key")
    }
    func removeAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
         }
    }
}

