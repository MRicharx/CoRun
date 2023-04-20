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
    @Published var sessionThisWeek = 0
    ///Define display data
    @Published var sessionDD = [SessionDisplayData()]
    
    override init(){
        super.init()
        sessionDD.removeAll()
    }
    
    override func refresh() {
        //TODO: Refresh Data
    }
    
    func loadSession(){
        //TODO: Get session data and load to display data
        getDummy()
        
        sessionThisWeek = sessionDD.count
        
        //TODO: Check this thing validity
        for data in sessionDD{
            if data.status.enume != .planNotDone{
                sessionPassed+=1
            }
        }
    }
    
    private func getDummy(){
        for i in 1...6{
            let temp = SessionDisplayData()
            
            temp.id = String(i)
            temp.coachName = "Coach \(i)"
            temp.date = Date.now
            temp.activityName = "Activity \(i)"
            temp.target = [
                TargetDisplayData(targetData: SessionTarget(targetType: 0, amount: Double(600*i))),
                TargetDisplayData(targetData: SessionTarget(targetType: 1, amount: Double(i))),
                TargetDisplayData(targetData: SessionTarget(targetType: 2, amount: Double(60*i))),
                TargetDisplayData(targetData: SessionTarget(targetType: 3, amount: 60))
            ]
            
            if(i<3){
                temp.status.set(newStatus: .planReachAllGoal)
            }
            else if i == 3{
                temp.status.set(newStatus: .planPartlyReachGoal)
            }
            else{
                temp.status.set(newStatus: .planNotDone)
            }
            
            temp.desc = "This is dummy session"
            temp.isUnread = false
            
            temp.result = ResultDisplayData()
            if i<4{
                temp.result.distance = Double(i)
                temp.result.avgBPM = 100
            }
            
            sessionDD.append(temp)
        }
    }
}
