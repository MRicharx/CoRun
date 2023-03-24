//
//  CCalendarCardViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

class CCalendarCardViewModel:ObservableObject{
    ///Define DateInterval for current month
    func defineDateInterval(date:Date)->DateInterval{
        let calendar = Calendar.current

        let monthInterval = calendar.dateInterval(of: .month, for: date)
        ///Define start of the interval
        let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval?.start ?? date)
        ///Define end of the interval
//        let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval?.end ?? date)
//        let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval?.end.next(.saturday) ?? date)
        
        return DateInterval(start: monthFirstWeek?.start ?? date, end: monthInterval?.end.next(.saturday) ?? date)
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
