//
//  ProfileData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class ProfileData:Codable,ObservableObject{
    ///Define user id
    var UserId = ""
    ///Define user registered email
    var Email = ""
    ///Define username
    var Username = ""
    ///Define gender
    var Gender = ""
    ///Define user height
    var Height = 99.9
    ///Define user weight
    var Weight = 99.9
    ///Define user's coach id
    var CoachId = ""
    ///Define date of birth
    var Birthday = ""
    
    func set(new:ProfileData){
        UserId = new.UserId
        Email = new.Email
        Username = new.Username
        Gender = new.Gender
        Height = new.Height
        Weight = new.Weight
        CoachId = new.CoachId
        Birthday = new.Birthday
    }
}
