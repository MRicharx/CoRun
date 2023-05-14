//
//  CDashboardViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 24/04/23.
//

import Foundation

class CDashboardViewModel:ObservableObject{
    private let sapi = SessionAPI()
    private let tapi = TraineeAPI()
    
    @Published var session = SessionDisplayData()
    
    @Published var dashboardDD = DashboardDisplayData()
    
    @Published var showDataInvalidAlert = false
    @Published var dataInvalidMessage = ""
    
    
    func loadData(){
//        generateDummy()
        dashboardDD.title = session.activityName
        if session.target.count>0{
            dashboardDD.targetDistance = String(format: "%.1f",session.target[1].amount/1000)
            dashboardDD.targetPaceMin = String(format: "%.0f",session.target[2].amount/60)
            dashboardDD.targetPaceSec = String(format: "%.0f",session.target[2].amount.truncatingRemainder(dividingBy: 60))
            dashboardDD.targetIntensity = String(format: "%.0f",session.target[3].amount)
            dashboardDD.targetDurationHour = String(format: "%.0f",session.target[0].amount/3600)
            dashboardDD.targetDurationMin = String(format: "%.0f",session.target[0].amount.truncatingRemainder(dividingBy: 3600)/60)
        } else{
            dashboardDD.targetDistance = ""
            dashboardDD.targetPaceMin = ""
            dashboardDD.targetPaceSec = ""
            dashboardDD.targetIntensity = ""
            dashboardDD.targetDurationHour = ""
            dashboardDD.targetDurationMin = ""
        }
        
        dashboardDD.desc = session.desc
        
    }
    
    func isDataValid()->Bool{
        if dashboardDD.title == ""{
            dataInvalidMessage = "Title can not be empty"
        }
        else{
            return true
        }
        
        showDataInvalidAlert = true
        return false
    }
    
    func validateData(ownId:String, traineeId:String)->SessionData{
        let i = Int(dashboardDD.targetIntensity) ?? 0
        let p = Int(dashboardDD.targetPaceSec) ?? 0 + (Int(dashboardDD.targetPaceMin) ?? 0) * 60
        let dur = (Int(dashboardDD.targetDurationHour) ?? 0) * 3600 + (Int(dashboardDD.targetDurationMin) ?? 0) * 60
        
        ///Set intensity boundary
        if i > 100{
            dashboardDD.targetIntensity = "100"
        }
        else if i < 0{
            dashboardDD.targetIntensity = "0"
        }
        
        ///Normalize duration and pace to second
        if dur > 0{
            dashboardDD.targetDurationHour = String(dur / 3600)
            dashboardDD.targetDurationMin = String(dur % 3600 / 60)
            
            dashboardDD.targetPaceMin = String(p/60)
            dashboardDD.targetPaceSec = String(p%60)
        }
        
        let data = SessionData()
        data.SessionId = session.id
        data.CoachId = ownId
        data.SessionDate = TDate().dateToString(date: session.date, format: "YYYY-MM-dd")
        data.Name = dashboardDD.title
        data.Description = dashboardDD.desc
        data.Status = 3
        data.UserId = traineeId
        data.Duration = Double(dur)
        data.Distance = (Double(dashboardDD.targetDistance) ?? 0) * 1000
        data.Pace = Double(p)
        data.Intensity = Double(i)
        
        return data
    }
    
    private func generateDummy(){
        let temp = DashboardDisplayData()
        temp.title = "Berlari-lari"
        temp.targetDistance = "10"
        temp.targetPaceMin = "3"
        temp.targetPaceSec = "20"
        temp.targetIntensity = "70"
        temp.targetDurationHour = "1"
        temp.targetDurationMin = "20"
        temp.desc = "Lari sepuasnya"
        
        dashboardDD = temp
    }
}
