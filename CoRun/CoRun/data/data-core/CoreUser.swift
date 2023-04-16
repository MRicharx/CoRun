//
//  CoreUser.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation
import CoreData

struct CoreUser:Codable{
    var id:String
    var refreshToken:String
    var gender:String
    var email:String
    var username:String
    var height:Int
    var weight:Int
    var coachName:String
    
    init(){
        id = ""
        refreshToken = ""
        gender = ""
        email = ""
        username = ""
        height = 99
        weight = 99
        coachName = ""
    }
    
//    mutating func updateData(new:CoreUser){
//        id = new.id
//        refreshToken = new.refreshToken
//        gender = new.gender
//        email = new.email
//        username = new.username
//        height = new.height
//        weight = new.weight
//        coachName = new.coachName
//    }
}
//
//class CoreUserController:ObservableObject{
//    let container = NSPersistentContainer(name: "User")
//
//    init() {
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                print("Core Data failed to load: \(error.localizedDescription)")
//            }
//        }
//    }
//}
