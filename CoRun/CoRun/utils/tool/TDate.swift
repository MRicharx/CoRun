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
    ///Return first date of selected month
    func getFirstDayOfMonth(month:Date)->Date
    ///Return last date of selected month
    func getLastDayOfMonth(month:Date)->Date
    ///Return first date of selected year
    func getFirstDayOfYear(year:Date)->Date
    ///Return last date of selected year
    func getLastDayOfYear(year:Date)->Date
    
    ///Compare 2 date data with dateformatter as comparrasion
    func compare(first:Date,second:Date, format:String)->Bool
    
    ///Return duration in HH(Int) mm(Int) ss(Int) format from seconds(Double)
    func secondToHMS(seconds:Double)->(Int,Int,Int)
    ///Return duration in mm'ss"(String) format from seconds(Double)
    func secondToPace(seconds:Double)->String
    ///Return date in Date Format
    func stringToDate(date:String, format:String)->Date
    ///Return date in String Format
    func dateToString(date:Date, format:String)->String
}
///This Struct define function declared at TDateProtocol
struct TDate:TDateProtocol{
    func compare(first: Date, second: Date, format: String) -> Bool {
        let comparasionFormat = DateFormatter()
        comparasionFormat.dateFormat = format
        
        if(comparasionFormat.string(from: first) == comparasionFormat.string(from: second)){
           return true
        }
        else{
            return false
        }
    }
    
    func getFirstDayOfMonth(month: Date) -> Date {
        ///Define Component
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: comp)!
    }
    func getLastDayOfMonth(month: Date) -> Date {
        ///Define Component
        var comp = DateComponents()
        comp.month = 1
        comp.second = -1
        
        ///Increment first day of month with date component and return the value
        return Calendar.current.date(byAdding: comp, to: getFirstDayOfMonth(month: month)) ?? Date.now
    }
    func getFirstDayOfYear(year: Date) -> Date {
        ///Define component
        let comp:DateComponents = Calendar.current.dateComponents([.year], from: year)
        return Calendar.current.date(from: comp)!
    }
    func getLastDayOfYear(year: Date) -> Date {
        ///Define Component
        var comp = DateComponents()
        comp.year = 1
        comp.second = -1
        
        ///Increment first day of year with date component and return value
        return Calendar.current.date(byAdding: comp, to: getFirstDayOfYear(year: year)) ?? Date.now
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
    func stringToDate(date:String,format:String = "yyyy-MM-dd HH:mm:ss")->Date{
        ///Formating string to Date Format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date) ?? Date.now
    }
    func dateToString(date:Date,format:String = "yyyy-MM-dd HH:mm:ss")->String{
        ///Formating string to Date Format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
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
