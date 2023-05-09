//
//  SessionDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 20/04/23.
//

import Foundation

class ListSessionDisplayData:ObservableObject{
    @Published var list:[SessionDisplayData]
    
    init(list:[SessionDisplayData]){
        self.list=list
    }
}

class SessionDisplayData:ObservableObject{
    @Published var id:String
    @Published var coachName:String
    @Published var date:Date
    @Published var activityName:String
    @Published var target:[TargetDisplayData]
    @Published var status:CompletionStatus
    @Published var desc:String
    @Published var isUnread:Bool
    
    @Published var result :ResultDisplayData
    
    init(){
        id = ""
        coachName = ""
        date = Date.now
        activityName = ""
        target = [TargetDisplayData]()
        status = CompletionStatus()
        desc = ""
        isUnread = false
        
        result = ResultDisplayData()
    }
    
    func initialize(sessionData:SessionData){
        id = String(sessionData.SessionId)
        date = TDate().stringToDate(date: sessionData.SessionDate, format: "YYYY-MM-DD")
        activityName = sessionData.Name
        
//        target = [TargetDisplayData]()
        
        status = CompletionStatus(status: sessionData.Status)
        desc = sessionData.Description
        
//        result = ResultDisplayData(resultData: sessionData.result)
        
//        target.removeAll()
//
//        for data in sessionData.target{
//            let t = TargetDisplayData(targetData: data)
//            target.append(t)
//        }
    }
}
