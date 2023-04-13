//
//  CalendarStatus.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import Foundation

///Class containing calendar status in enum and int
class CalendarStatus:ObservableObject{
    ///Define status
    ///0 - plan did not exist,
    ///1 - Goal not reached,
    ///2 - Some Goal reached,
    ///3 - All goal reached,
    ///else - Activity yet to be done
    @Published var int:Int
    @Published var enume:enumCalendarStatus
    
    init(){
        int = 0
        enume = .noPlan
    }
    
    func set(newStatus:enumCalendarStatus){
        enume = newStatus
        
        switch(enume){
        case .noPlan:
            int = 0
        case .planNotReachGoal:
            int = 1
        case .planPartlyReachGoal:
            int = 2
        case .planReachAllGoal:
            int = 3
        case .planNotDone:
            int = 4 
        }
    }
}

enum enumCalendarStatus{
    case noPlan
    case planNotDone
    case planNotReachGoal
    case planPartlyReachGoal
    case planReachAllGoal
}
