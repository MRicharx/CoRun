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
    func getUserAge(birth:Date) ->Int{
        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: birth, to: Date.now)
        let age = ageComponents.year!
        
        return age
    }
    
    ///Return date today at 00:00 right at midnight
    func getStartDate()->Date{
        let calendar = Calendar(identifier: .gregorian)
//        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let startOfDate = calendar.startOfDay(for: Date())
        
        return startOfDate
    }
    
    ///Return date today at 23:59:59 right before midnight
    func getEndDate()->Date{
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.second = -1
        
        let start = getStartDate()
        let endOfDate = Calendar.current.date(byAdding: dateComponent, to: start)
        
        return endOfDate ?? Date.now
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
        var c = DateComponents()
        c.day = 1
        
        let d = Calendar.current.date(from: comp) ?? Date.now
        return Calendar.current.date(byAdding: c, to: d) ?? Date.now
    }
    func getLastDayOfYear(year: Date) -> Date {
        ///Define Component
        var comp = DateComponents()
        comp.year = 1
        comp.day = -1
        
        ///Increment first day of year with date component and return value
        return Calendar.current.date(byAdding: comp, to: getFirstDayOfYear(year: year)) ?? Date.now
    }
    
    func getSecondBetweenDate(start: Date, end: Date)->Double{
        return end.timeIntervalSince(start)
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
    func getStringinHMS(seconds:Double)->String{
        var hour = 0
        var min = 0
        var sec = 0
        let time = Int(seconds)
        
        hour = time / 3600
        min = time % 3600 / 60
        sec = time % 3600 % 60
        
        var result = ""
        
        ///More than 100 hour
        if hour>=100{
            let day = hour/24
            let h = hour%24
            
            result = "\(day)D \(h)H"
        }
        ///Less than 100 hour
        else{
            result += "\(hour):"
            if min<10{
                result+="0"
            }
            result+="\(min):"
            if sec<10{
                result+="0"
            }
            result += "\(sec)"
        }
        
        return result
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
