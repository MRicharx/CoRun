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
        sessionPassed=0

        ///Set this week interval
        var start = TDate().getStartDate()
        var end = TDate().getEndDate()
        if TDate().dateToString(date: Date.now,format: "EEEE") != "Sunday"{
            start = start.previous(.sunday)
        }
        if TDate().dateToString(date: Date.now,format: "EEEE") != "Saturday"{
            end = end.next(.saturday)
        }
        
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
            
            d.result.start = TDate().stringToDate(date: data.ResultDate)
            d.result.duration = data.ResultDuration
            d.result.distance = data.ResultDistance
            d.result.avgBPM = data.AvgBPM
            d.result.vo2M = data.AvgVo2
            d.result.verticalOsc = data.VerOsc
            d.result.stride = data.Stride
            d.result.elevGain = data.ElevGain
            d.result.groundTime = data.GroundTime
            d.desc = data.Description
            
            d.score = data.Score
            
            d.status = CompletionStatus(status: data.Status)
            
            print(">> Start Week : \(start)")
            print(">> End Week : \(end)")
            if start <= d.date && d.date <= end{
                
                if d.status.int != 3{
                    sessionPassed+=1
                }
                
                sessionDD.append(d)
            }
        }
        
//        sort()
        sessionThisWeek = sessionDD.count

//        print(">> PlanViewModel: session this week: \(sessionThisWeek)")
//        print(">> PlanViewModel: session done: \(sessionPassed)")
    }

}
