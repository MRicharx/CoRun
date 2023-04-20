//
//  SessionData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class SessionData:Codable{
    ///Define session id
    var id = ""
    ///Define session creator id
    var coachID = ""
    ///Define session creator
    var coachName = ""
    ///Define session date
    var date = Date.now
    ///Define session name
    var activityName = "NaN"
    ///Define target that need to be reached on this session
    var target = [SessionTarget()]
    ///Define session completion status
    var status = 3
    ///Define session description
    var description = ""
    ///Define if unread feedback exist
    var isFeedbackUnread = false
    
    var result = SessionResultData()
}

class SessionTarget:Codable{
    var targetType = -1
    var amount = Double(0)
    
    init(targetType: Int = 1, amount: Double = Double(0)) {
        self.targetType = targetType
        self.amount = amount
    }
}

