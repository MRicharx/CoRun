//
//  SessionDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 20/04/23.
//

import Foundation

class ListSessionDisplayData:ObservableObject{
    @Published var list:[SessionDisplayData]
    
    init(){
        list = [SessionDisplayData]()
    }
    
    init(list:[SessionDisplayData]){
        self.list=list
    }
}

class SessionDisplayData:ObservableObject{
    @Published var id:Int
    @Published var coachId:String
    @Published var coachName:String
    @Published var date:Date
    @Published var activityName:String
    @Published var target:[TargetDisplayData]
    @Published var status:CompletionStatus
    @Published var desc:String
    @Published var score:Int
    
    @Published var result :ResultDisplayData
    
    init(){
        id = 0
        coachId = ""
        coachName = ""
        date = Date.now
        activityName = ""
        target = [TargetDisplayData]()
        status = CompletionStatus()
        desc = ""
        score = 0
        
        result = ResultDisplayData()
    }
    
//    func initialize(sessionData:SessionData){
//        id = sessionData.SessionId
//        coachId = sessionData.CoachId
//        coachName = ""
//        date = TDate().stringToDate(date: sessionData.SessionDate, format: "YYYY-MM-DD")
//        activityName = sessionData.Name
//
////        target = [TargetDisplayData]()
//
//        status = CompletionStatus(status: sessionData.Status)
//        desc = sessionData.Description
//
////        result = ResultDisplayData(resultData: sessionData.result)
//
////        target.removeAll()
////
////        for data in sessionData.target{
////            let t = TargetDisplayData(targetData: data)
////            target.append(t)
////        }
//    }
}
