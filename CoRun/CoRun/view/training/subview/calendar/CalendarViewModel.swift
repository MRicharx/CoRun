//
//  CalendarViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import Foundation

class CalendarViewModel: TrainingViewModel{
    ///Define display data
    @Published var sessionDD = [SessionDisplayData]()
    ///Define selected date
    @Published var selectedDate = Date.now
    ///Define selected session display data
    @Published var selectedSession = SessionDisplayData()
    ///Define is data loaded
    @Published var isLoaded = false
    
    private let sapi = SessionAPI()
    
    override init(){
        super.init()
        sessionDD.removeAll()
    }
    
    func loadSession(session: [SessionData]){
        isLoaded = false
        sessionDD.removeAll()
        
        for data in session{
            let d = SessionDisplayData()
            
            d.id = data.SessionId
            d.coachId = data.CoachId
            d.coachName = "Coach --"
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
            
            sessionDD.append(d)
        }
        findSession(byDate: selectedDate)
        
        isLoaded = true
    }
    func findSession(byDate:Date){
        if let session = sessionDD.first(where: {TDate().compare(first: $0.date, second: selectedDate, format: "dd MMMM YYYY")}){
            selectedSession = session
        }else{
            let temp = SessionDisplayData()
            temp.date = selectedDate
            selectedSession = temp
        }
        
        print(">> CalendarViewModel: Selected Session ID, CoachId: [\n\(selectedSession.id)\n\(selectedSession.coachId)]")
    }
}
