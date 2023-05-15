//
//  SummaryViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import Foundation

class SummaryViewModel: ObservableObject{
    var model = SummaryModel()
    
    ///Define selected option
    @Published var displayOption:String = "Week"
    ///Define list of display option
    @Published var listOption = ["Week","Month","Year"]
    ///Define current selected date
    @Published var currentDate = Date.now
    
    ///Define distance ran value
    @Published var distanceRan: Double = 0
    ///Define total run value
    @Published var totalRun: Int = 0
    ///Define average pace value
    @Published var avgPace: Double = 0
    ///Define total run time value
    @Published var runTime: Double = 0
    
    ///Define graph data
    @Published var graphData = GraphDisplayDataList(amount: [],label:[])
    
    ///Load data
    func loadData(session: [SessionData]){
        ///Empty all display data
        graphData.clear()
        distanceRan = 0
        totalRun = 0
        avgPace = 0
        runTime = 0
        
        var pCounter=0
        
        ///Define summary date range
        var start = Date.now
        var end = Date.now
        
        ///Define the date range based on displayed option
        switch displayOption{
        case "Week":
            if TDate().dateToString(date: currentDate, format: "EEEE") != "Sunday"{
                start = currentDate.previous(.sunday)
            }
            if TDate().dateToString(date: currentDate,format: "EEEE") != "Saturday"{
                end = currentDate.next(.saturday)
            }
            
        case "Month":
            start = TDate().getFirstDayOfMonth(month: currentDate)
            end = TDate().getLastDayOfMonth(month: currentDate)
            
        case "Year":
            start = TDate().getFirstDayOfYear(year: currentDate)
            end = TDate().getLastDayOfYear(year: currentDate)
        default://MARK: by year here
            break
        }
        
        
        ///Re Calculate all display data
        for data in session{
            let date = TDate().stringToDate(date: data.ResultDate)
            
            ///Check if data satisfied the date range
            ///and append to graph data
            if start < date && date < end{
                ///If session have result
                if data.Status != 3{
                    distanceRan += data.ResultDuration
                    totalRun += 1
                    runTime += data.ResultDuration

                    pCounter+=1
                    
                    ///Append data to graph array
                    graphData.amount.append(data.ResultDistance)
                    switch displayOption{
                    case "Week":
                        graphData.label.append(TDate().dateToString(date: date,format: "EEEE"))
                    case "Month":
                        graphData.label.append(TDate().dateToString(date: date,format: "dd"))
                    case "Year":
                        graphData.label.append(TDate().dateToString(date: date,format: "MMMM"))
                    default:
                        break
                    }
                }
            }
        }
        
        if distanceRan>0 && runTime>0{
            avgPace = runTime/(distanceRan/1000)
        }
//        generateDummy()
    }
    ///Return week range in string
    func weekRange()->String{
        var start = currentDate
        if(TDate().dateToString(date: start,format:"EEEE") != "Monday"){
            start = currentDate.previous(.monday)
        }
        var end = currentDate
        if(TDate().dateToString(date: start,format:"EEEE") != "Sunday"){
            end = currentDate.next(.sunday)
        }
        
        if(TDate().compare(first: start, second: end, format: "MM")){
            return "\(TDate().dateToString(date: start,format: "d")) - \(TDate().dateToString(date: end,format: "d MMMM YYYY"))"
        }
        else if(TDate().compare(first: start, second: end, format: "YY")){
            return "\(TDate().dateToString(date: start,format: "d MMMM")) - \(TDate().dateToString(date: end,format: "d MMMM YYYY"))"
        }
        else{
            return "\(TDate().dateToString(date: start,format: "d MMMM YYYY")) - \(TDate().dateToString(date: end,format: "d MMMM YYYY"))"
        }
    }
    ///Navigate current date to previous date based on display option
    func prev(){
        var comp = DateComponents()
        switch(displayOption){
        case "Week":
            comp.day = -7
        case "Month":
            comp.month = -1
        case "Year":
            comp.year = -1
        default:
            comp.day = 0
        }
        
        currentDate = Calendar.current.date(byAdding: comp, to: currentDate) ?? Date.now
    }
    ///Navigate current date to next date based on display option
    func next(){
        var comp = DateComponents()
        switch(displayOption){
        case "Week":
            comp.day = 7
        case "Month":
            comp.month = 1
        case "Year":
            comp.year = 1
        default:
            comp.day = 0
        }
        
        currentDate = Calendar.current.date(byAdding: comp, to: currentDate) ?? Date.now
    }
    
    func updateDisplayOption(dp:String){
        displayOption = dp
        graphData.clear()
        
        //TODO: Load session data by displayOption
        switch dp{
        case "Week":
            graphData = GraphDisplayDataList(amount: [1,3,2,4,12,2],label:["Sun","Mon","Tue","Wed","Thu","Fri","Sat"])
        case "Month":
            graphData = GraphDisplayDataList(amount: [10,21,13,14,2],label:["W1","W2","W3","W4","W5"])
            
        case "Year":
            graphData = GraphDisplayDataList(amount: [10,21,13,14,2,5,12,8,8,15,10,12],label:["Jan","Feb","Mar","Apr","May","Jn","Jl","Aug","Sep","Okt","Nov","Des"])
        default:
            graphData.clear()
            break
        }
    }
    
}
