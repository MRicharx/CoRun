//
//  CalendarViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import Foundation

class CalendarViewModel: TrainingViewModel{
    ///Define display data
    @Published var sessionDD = [SessionDisplayData()]
    ///Define selected date
    @Published var selectedDate = Date.now
    ///Define if selected date have session
    @Published var isSessionExist = false
    ///Define selected session display data
    @Published var selectedSession = SessionDisplayData()
    
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

    }
    func findSession(byDate:Date){
        if let session = sessionDD.first(where: {TDate().compare(first: $0.date, second: selectedDate, format: "dd MMMM YYYY")}){
            isSessionExist = true
            selectedSession = session
        }else{
            let temp = SessionDisplayData()
            temp.date = selectedDate
            isSessionExist = false
            selectedSession = temp
        }
    }
    
    private func getDummy(){
        for i in 1...6{
            let temp = SessionDisplayData()
            ///Define Component
            var comp = DateComponents()
            comp.day = -(i)
            
            temp.id = String(i)
            temp.coachName = "Coach \(i)"
            temp.date = Calendar.current.date(byAdding: comp, to: Date.now) ?? Date.now
            temp.activityName = "Activity \(i)"
//            temp.target = [
//                TargetDisplayData(targetData: SessionTarget(targetType: 0, amount: Double(600*i))),
//                TargetDisplayData(targetData: SessionTarget(targetType: 1, amount: Double(i))),
//                TargetDisplayData(targetData: SessionTarget(targetType: 2, amount: Double(60*i))),
//                TargetDisplayData(targetData: SessionTarget(targetType: 3, amount: 60))
//            ]
            
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
