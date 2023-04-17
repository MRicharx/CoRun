//
//  ProfileData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class ProfileData:Codable{
    ///Define user id
    var id = ""
    ///Define user registered email
    var email = ""
    ///Define username
    var username = ""
    ///Define date of birth
    var dateOfBirth = ""
    ///Define gender
    var gender = ""
    ///Define user height
    var height = 99
    ///Define user weight
    var weight = 99
    
    ///Define user's coach id
    var coachId = ""
    ///Define user's coach's name
    var coachName = ""
    
    ///Define login token
    var signToken = ""
    ///Define notification token for identifier
    var notificationToken = ""
}
