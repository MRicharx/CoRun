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
    @Published var gender:String
    @Published var height:Int
    @Published var weight:Int
    @Published var coachName:String
    @Published var isReminderActive:Bool
    @Published var reminderValue:Date
    @Published var isHealthAllowed:Bool
    
    init() {
        self.id = "NaN"
        self.username = "NaN"
        self.email = "NaN@NaN.NaN"
        self.height = 99
        self.weight = 99
        self.gender = "NaN"
        self.coachName = "NaN"
        self.isReminderActive = true
        self.reminderValue = Calendar.current.date(bySettingHour: 7, minute: 00, second: 0, of: Date())!
        self.isHealthAllowed = true
    }
    
}
