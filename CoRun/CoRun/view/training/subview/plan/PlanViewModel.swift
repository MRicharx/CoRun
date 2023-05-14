//
//  TrainingPlanModel.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

class PlanViewModel: TrainingViewModel{
    ///Define session passed/done
    @Published var sessionPassed = 0
    ///Define total to do session this week
    @Published var sessionThisWeek = 1
    ///Define display data
    @Published var sessionDD = [SessionDisplayData()]
    
    override init(){
        super.init()
        sessionDD.removeAll()
    }
    
    func loadSession(session: [SessionData]){
        sessionDD.removeAll()

//        getDummy()
        for data in session{
            let d = SessionDisplayData()
            
            d.id = data.SessionId
            d.coachId = data.CoachId
            d.coachName = "-"
            d.date = TDate().stringToDate(date: data.SessionDate,format: "YYYY-MM-dd")
            d.activityName = data.Name
            d.target = [
                TargetDisplayData(type: 0 ,amount: data.Duration),
                TargetDisplayData(type: 1 , amount: data.Distance),
                TargetDisplayData(type: 2, amount: data.Pace),
                TargetDisplayData(type: 3, amount: data.Intensity)
            ]
            
            d.desc = data.Description
            d.score = data.Score
            
            d.status = CompletionStatus(status: data.Status)
            if d.status.int != 3{
                sessionPassed+=1
            }
            
            sessionDD.append(d)
        }
        
        sessionThisWeek = sessionDD.count

//        print(">> PlanViewModel: session this week: \(sessionThisWeek)")
//        print(">> PlanViewModel: session done: \(sessionPassed)")
    }
    
//    private func getDummy(){
//        for i in 1...6{
//            let temp = SessionDisplayData()
//
//            temp.id = i
//            temp.coachName = "Coach \(i)"
//            temp.date = Date.now
//            temp.activityName = "Activity \(i)"
////            temp.target = [
////                TargetDisplayData(targetData: SessionTarget(targetType: 0, amount: Double(600*i))),
////                TargetDisplayData(targetData: SessionTarget(targetType: 1, amount: Double(i))),
////                TargetDisplayData(targetData: SessionTarget(targetType: 2, amount: Double(60*i))),
////                TargetDisplayData(targetData: SessionTarget(targetType: 3, amount: 60))
////            ]
//
//            if(i<3){
//                temp.status.set(newStatus: .planReachAllGoal)
//            }
//            else if i == 3{
//                temp.status.set(newStatus: .planPartlyReachGoal)
//            }
//            else{
//                temp.status.set(newStatus: .planNotDone)
//            }
//
//            temp.desc = "This is dummy session"
//            temp.isUnread = false
//
//            temp.result = ResultDisplayData()
//            if i<4{
//                temp.result.distance = Double(i)
//                temp.result.avgBPM = 100
//            }
//
//            sessionDD.append(temp)
//        }
//    }
}
