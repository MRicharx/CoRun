//
//  SessionData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class SessionData:Codable,ObservableObject{
    ///Define session id
    var SessionId = 0
    ///Define session creator id
    var CoachId = ""
    ///Define session date
    var SessionDate = ""
    ///Define session name
    var Name = ""
    ///Define session description
    var Description = ""
    ///Define session completion status
    var Status = 3
    ///Define own user id
    var UserId = ""
    ///Define target duration in second
    var Duration = 0.0
    ///Define target distance in kilometer
    var Distance = 0.0
    ///Define target pace in second
    var Pace = 0.0
    ///Define target intensity in percentage
    var Intensity = 0.0
    ///Define Result date
    var ResultDate = ""
    ///Define result duration
    var ResultDuration = 0.0
    ///Define result distance
    var ResultDistance = 0.0
    ///Define average beat per minute
    var AvgBPM = 0.0
    ///Define average vo2 max
    var AvgVo2 = 0.0
    ///Define vertical oscilation
    var VerOsc = 0.0
    ///Define stride
    var Stride = 0.0
    ///Define elevation gain
    var ElevGain = 0.0
    ///Define ground time duration
    var GroundTime = 0.0
}


//class SessionTarget:Codable{
//    var targetType = -1
//    var amount = Double(0)
//
//    init(targetType: Int = 1, amount: Double = Double(0)) {
//        self.targetType = targetType
//        self.amount = amount
//    }
//}

///Class type for testing purposes plz dont mind
class rawSession:Codable{
    ///Define session id
    var SessionId = 0
    ///Define session creator id
    var CoachId = ""
    ///Define session date
    var SessionDate = ""
    ///Define session name
    var Name = "NaN"
    ///Define session description
    var Description = ""
    ///Define session completion status
    var Status = 3
    
    var UserId = ""
}

