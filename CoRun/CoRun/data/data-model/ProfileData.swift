//
//  ProfileData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class ProfileData:Decodable{
    ///Define user id
    var id = ""
    ///Define user registered email
    var email = ""
    ///Define username
    var username = ""
    ///Define gender
    var gender = ""
    ///Define user height
    var height = ""
    ///Define user weight
    var weight = ""
    
    ///Define user's coach id
    var coachId = ""
    ///Define user's coach's name
    var coachName = ""
    
    ///Define login token
    var signToken = ""
    ///Define notification token for identifier
    var notificationToken = ""
}
