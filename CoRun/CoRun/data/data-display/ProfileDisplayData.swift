//
//  ProfileDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation

class ProfileDisplayData:ObservableObject{
    @Published var id:String
    @Published var username:String
    @Published var email:String
    @Published var birthday:Date
    @Published var gender:String
    @Published var height:Int
    @Published var weight:Int
    @Published var coachName:String
    
    init() {
        self.id = "NaN"
        self.username = "NaN"
        self.email = "NaN@NaN.NaN"
        self.birthday = Date.now
        self.height = 99
        self.weight = 99
        self.gender = "NaN"
        self.coachName = "NaN"
    }
    
}
