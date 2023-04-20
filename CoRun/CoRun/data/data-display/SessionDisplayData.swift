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
        id = sessionData.id
        coachName = sessionData.coachName
        date = sessionData.date
        activityName = sessionData.activityName
        
        target = [TargetDisplayData]()
        
        status = CompletionStatus(status: sessionData.status)
        desc = sessionData.description
        isUnread = sessionData.isFeedbackUnread
        
        result = ResultDisplayData(resultData: sessionData.result)
        
        target.removeAll()

        for data in sessionData.target{
            let t = TargetDisplayData(targetData: data)
            target.append(t)
        }
    }
}
