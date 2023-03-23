//
//  HDate.swift
//  CoRun
//
//  Created by Marselus Richard on 19/03/23.
//

import Foundation

///TDate - Date Tool
///This Protocol contain list of func to help handling date format
protocol TDateProtocol{
    ///Return duration between 2 date in seconds (Double)
    ///With String as parameter
    func getTimeBetweenDate(start:String, end:String)->Double
    ///Return duration between 2 date in seconds (Double)
    ///With Date as parameter
    func getTimeBetweenDate(start:Date, end:Date)->Double
    ///Return remaining time till midnight in seconds (Double)
    func getDurationTillMidnight()->Double
    ///Return remaining time till next monday in days (Int)
    func getDurationTillNextMonday()->Double
    
    ///Return first date of selected month
    func getFirstDayOfMonth(month:Date)->Date
    ///Return last date of selected month
    func getLastDayOfMonth(month:Date)->Date
    ///Return first date of selected year
    func getFirstDayOfYear(year:Date)->Date
    ///Return last date of selected year
    func getLastDayOfYear(year:Date)->Date
    
    ///Return Array of Date for selected Month
    func generateDate(month:Int)->[Int]
    
    ///Return duration in HH(Int) mm(Int) ss(Int) format from seconds(Double)
    func secondToHMS(seconds:Double)->(Int,Int,Int)
    ///Return duration in mm'ss"(String) format from seconds(Double)
    func secondToPace(seconds:Double)->String
    ///Return date in Date Format
    func stringToDate(date:String)->Date
    ///Return date in String Format
    func dateToString(date:Date)->String
}
///This Struct define function declared at TDateProtocol
struct TDate:TDateProtocol{
    ///Default Date Format that will be used
    let dateFormatter: () = DateFormatter().dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
    
    func getTimeBetweenDate(start:String, end:String)->Double{
        ///Formating string to Date Format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        
        ///Translate String to Date
        let startDate = dateFormatter.date(from:start)
        let endDate = dateFormatter.date(from:end)
        
        return endDate?.timeIntervalSince(startDate ?? Date.now) ?? 0
    }
    func getTimeBetweenDate(start:Date, end:Date)->Double{
        return end.timeIntervalSince(start)
    }
    func getDurationTillMidnight()->Double{
        let calendar = Calendar(identifier: .gregorian)
        let start = Date.now
        
        ///Define next midnight
        ///Which current date 00.00 incremented by 1 day
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let end = Calendar.current.date(byAdding: dateComponent, to: calendar.startOfDay(for: Date.now))
        
        ///Calculate and return interval
        return Double(TDate.init().getTimeBetweenDate(start: start, end: end ?? Date.now))
    }
    func getDurationTillNextMonday() -> Double {
        let start = Date.now
        let end = Date.today().next(.monday)
        
        ///Calculate and return interval
        return Double(TDate.init().getTimeBetweenDate(start: start, end: end))

    }
    
    //TODO: Test This
    func getFirstDayOfMonth(month: Date) -> Date {
        ///Define Component
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: comp)!
    }
    //TODO: Test This
    func getLastDayOfMonth(month: Date) -> Date {
        ///Define Component
        var comp = DateComponents()
        comp.month = 1
        comp.second = -1
        
        ///Increment first day of month with date component and return the value
        return Calendar.current.date(byAdding: comp, to: getFirstDayOfMonth(month: month)) ?? Date.now
    }
    //TODO: Test This
    func getFirstDayOfYear(year: Date) -> Date {
        ///Define component
        let comp:DateComponents = Calendar.current.dateComponents([.year], from: year)
        return Calendar.current.date(from: comp)!
    }
    //TODO: Test This
    func getLastDayOfYear(year: Date) -> Date {
        ///Define Component
        var comp = DateComponents()
        comp.year = 1
        comp.second = -1
        
        ///Increment first day of year with date component and return value
        return Calendar.current.date(byAdding: comp, to: getFirstDayOfYear(year: year)) ?? Date.now
    }
    
    //TODO: Create solution for this
    func generateDate(month: Int) -> [Int] {
        ///Define used format
        let format: () = DateFormatter().dateFormat = "yyyy-MM-dd"
        ///Define returned array of date
        var date: [Int] = []
        
        return [0]
    }
    
    func secondToHMS(seconds:Double)->(Int,Int,Int){
        var hour = 0
        var min = 0
        var sec = 0
        let time = Int(seconds)
        
        hour = time / 3600
        min = time % 3600 / 60
        sec = time % 3600 % 60
        
        return (hour,min,sec)
    }
    func secondToPace(seconds: Double) -> String {
        var min = 0
        var sec = 0
        let time = Int(seconds)
        
        min = time / 60
        sec = time % 3600 % 60
        
        return String(min) + "\'" + String(sec) + "\""
    }
    func stringToDate(date:String)->Date{
        ///Formating string to Date Format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        
        return dateFormatter.date(from: date) ?? Date.now
    }
    func dateToString(date:Date)->String{
        ///Formating string to Date Format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}


// MARK: Helper methods
extension Date {

  static func today() -> Date {
      return Date()
  }

  func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.next,
               weekday,
               considerToday: considerToday)
  }

  func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
    return get(.previous,
               weekday,
               considerToday: considerToday)
  }

  func get(_ direction: SearchDirection,
           _ weekDay: Weekday,
           considerToday consider: Bool = false) -> Date {

    let dayName = weekDay.rawValue

    let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }

    assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")

    let searchWeekdayIndex = weekdaysName.firstIndex(of: dayName)! + 1

    let calendar = Calendar(identifier: .gregorian)

    if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
      return self
    }

    var nextDateComponent = calendar.dateComponents([.hour, .minute, .second], from: self)
    nextDateComponent.weekday = searchWeekdayIndex

    let date = calendar.nextDate(after: self,
                                 matching: nextDateComponent,
                                 matchingPolicy: .nextTime,
                                 direction: direction.calendarSearchDirection)

    return date!
  }

}

extension Date {
  func getWeekDaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US_POSIX")
    return calendar.weekdaySymbols
  }

  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }

  enum SearchDirection {
    case next
    case previous

    var calendarSearchDirection: Calendar.SearchDirection {
      switch self {
      case .next:
        return .forward
      case .previous:
        return .backward
      }
    }
  }
}
