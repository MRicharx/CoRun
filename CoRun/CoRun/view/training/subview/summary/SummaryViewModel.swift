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
    ///Define graph data
    @Published var graphData:[Double] = [10,21,13,14,2,5,12,8,8,15]
    
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
