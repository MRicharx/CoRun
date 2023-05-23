//
//  SummaryViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import Foundation

class SummaryViewModel: ObservableObject{
    
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
    
    internal var start = Date.now
    internal var end = Date.now
    internal var label = [String]()
    
    ///Load data
    func loadData(session: [SessionData]){
        ///Empty all display data
        graphData.clear()
        label.removeAll()
        distanceRan = 0
        totalRun = 0
        avgPace = 0
        runTime = 0
        
        ///Define the date range based on displayed option
        switch displayOption{
        case "Week":
            if TDate().dateToString(date: currentDate, format: "EEEE") != "Sunday"{
                start = currentDate.previous(.sunday)
            }
            if TDate().dateToString(date: currentDate,format: "EEEE") != "Saturday"{
                end = currentDate.next(.saturday)
            }
            
            //Define week label
            var date = start
            label.append(TDate().dateToString(date: date, format: "EE"))
            while(!(TDate().compare(first: date, second: end, format: "dd-MMMM-YYYY"))){
                date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
                label.append(TDate().dateToString(date: date, format: "EE"))
            }
            
            
        case "Month":
            start = TDate().getFirstDayOfMonth(month: currentDate)
            end = TDate().getLastDayOfMonth(month: currentDate)
            
            //Define month label
            var date = start
            label.append(TDate().dateToString(date: date, format: "d"))
            while(!(TDate().compare(first: date, second: end, format: "dd-MMMM-YYYY"))){
                date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
                label.append(TDate().dateToString(date: date, format: "d"))
            }
            
        case "Year":
            start = TDate().getFirstDayOfYear(year: currentDate)
            end = TDate().getLastDayOfYear(year: currentDate)
            
            //Define year label
            var date = start
            while(!(TDate().compare(first: date, second: end, format: "MMMM-YYYY"))){
                label.append(TDate().dateToString(date: date, format: "MMM"))

                date = Calendar.current.date(byAdding: .month, value: 1, to: date) ?? date
            }
            
        default://MARK: by year here
            break
        }
        
        ///Input Empty Array
        for data in label{
            graphData.amount.append(0)
            graphData.label.append(data)
        }
        
        ///Re Calculate all display data
        for data in session{
            let date = TDate().stringToDate(date: data.SessionDate, format: "yyyy-MM-dd")
            
            ///Check if data satisfied the date range
            ///and append to graph data
            if start < date && date < end{
                ///If session have result
                if data.Status != 3{
                    distanceRan += data.ResultDistance/1000
                    totalRun += 1
                    runTime += data.ResultDuration
                    
                    ///Append data to graph array
                    graphData.amount.append(data.ResultDistance/1000)
                    switch displayOption{
                    case "Week":
                        graphData.label.append(TDate().dateToString(date: date,format: "EE"))
                    case "Month":
                        graphData.label.append(TDate().dateToString(date: date,format: "d"))
                    case "Year":
                        graphData.label.append(TDate().dateToString(date: date,format: "MMM"))
                    default:
                        break
                    }
                }
            }
        }
        
        if distanceRan>0 && runTime>0{
            avgPace = runTime/(distanceRan)
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
}
