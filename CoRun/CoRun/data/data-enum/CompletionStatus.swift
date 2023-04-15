//
//  CompletionStatus.swift
//  CoRun
//
//  Created by Marselus Richard on 11/04/23.
//

import Foundation

///Class containing session completion status in enum and int
class CompletionStatus:ObservableObject{
    ///Define status
    ///0 - Goal not reached,
    ///1 - Some Goal reached,
    ///2 - All goal reached,
    ///3 - Activity yet to be done
    @Published var int:Int
    @Published var enume:enumCompletionStatus
    
    init(){
        int = 0
        enume = .planNotDone
    }
    
    init(status:Int){
        int = status
        enume = .planNotReachGoal
        
        switch(int){
        case 0:
            enume = .planNotReachGoal
        case 1:
            enume = .planPartlyReachGoal
        case 2:
            enume = .planReachAllGoal
        default :
            enume = .planNotDone
        }
    }
    
    func set(newStatus:enumCompletionStatus){
        enume = newStatus
        
        switch(enume){
        case .planNotReachGoal:
            int = 0
        case .planPartlyReachGoal:
            int = 1
        case .planReachAllGoal:
            int = 2
        case .planNotDone:
            int = 3
        }
    }
}

enum enumCompletionStatus{
    case planNotDone
    case planNotReachGoal
    case planPartlyReachGoal
    case planReachAllGoal
}
