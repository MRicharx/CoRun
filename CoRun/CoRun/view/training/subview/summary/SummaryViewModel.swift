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
    @Published var listOption = ["Week","Month","Year","All"]
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
    func loadData(){
        graphData.clear()
        generateDummy()
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
    
    ///Generate dummy
    private func generateDummy(){
        distanceRan = 167.5
        totalRun = 8
        avgPace = 389
        runTime = 750000
        
        graphData = GraphDisplayDataList(amount: [1,3,2,4,12,2,8],label:["Sun","Mon","Tue","Wed","Thu","Fri","Sat"])
//        graphData = GraphDisplayDataList(amount: [10,21,13,14,2,5,12,8,8,15,10,12],label:["Jan","Feb","Mar","Apr","May","Jn","Jl","Aug","Sep","Okt","Nov","Des"])
    }
}
