//
//  CCalendarViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import SwiftUI

class CCalendarViewModel:ObservableObject{
    ///Define displayed month
    @Published var curMonth = Date.now
    ///Define date
    @Published var date = [DayData]()
    ///Define is data updated
    @Published var reload = false
    
    ///return session if exist
    func findSession(data: [SessionDisplayData],byDate:Date)->CompletionStatus{

        if let session = data.first(where: {TDate().compare(first: $0.date, second: byDate, format: "dd MMMM YYYY")}){
            return session.status
        }else{
            return CompletionStatus(status: 4)
        }
    }
    
    ///Generate date
    func getDate(sessionData:ListSessionDisplayData){
        let dates = generateDate(month: curMonth)
        date.removeAll()
        reload = true
        
        for d in dates{
            let temp = DayData()
            temp.date = d
            temp.day = TDate().dateToString(date: d,format: "d")
            temp.status = findSession(data: sessionData.list, byDate: d)
            if TDate().compare(first: d, second: curMonth, format: "MM"){
                temp.isDisabled=false
            }else{
                temp.isDisabled=true
            }
            date.append(temp)
        }
        
        reload = false
    }
    
    ///Increment date to next month
    func nextMonth(){
        var comp = DateComponents()
        comp.month = 1
        
        curMonth = Calendar.current.date(byAdding: comp, to: curMonth) ?? Date.now
    }
    
    ///Decrement date to last month
    func lastMonth(){
        var comp = DateComponents()
        comp.month = -1
        
        curMonth = Calendar.current.date(byAdding: comp, to: curMonth) ?? Date.now
    }
    
    ///Define DateInterval for current month
    private func defineDateInterval(date:Date)->DateInterval{
        let calendar = Calendar.current

        let monthInterval = calendar.dateInterval(of: .month, for: date)
        ///Define start of the interval
        let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval?.start ?? date)
        ///Define end of the interval
        let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval?.end ?? date)
//        let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval?.end.next(.saturday) ?? date)
        
        if(TDate().dateToString(date: monthLastWeek?.end ?? date,format: "EEEE") == "Sunday"){
            return DateInterval(start: monthFirstWeek?.start ?? date, end: monthLastWeek?.end.previous(.saturday) ?? date)
        }
        else{
            return DateInterval(start: monthFirstWeek?.start ?? date, end: monthInterval?.end.next(.saturday) ?? date)
        }
    }
    
    ///Generate Date to be loaded on card
    func generateDate(month:Date)->[Date]{
        let interval = defineDateInterval(date: month)
        var comp = DateComponents()
        comp.day = 1
        
        ///Define incremented date
        var date = interval.start
        ///Define returned array
        var dates = [Date]()
        dates.append(date)
        
        ///Append all date between interval
        while(dates.last != interval.end){
            date = Calendar.current.date(byAdding: .day, value: 1, to: date) ?? date
            dates.append(date)
        }
//        dates.append(date)
        
        return dates
    }
}
