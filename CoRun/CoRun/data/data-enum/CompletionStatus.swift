//
//  CompletionStatus.swift
//  CoRun
//
//  Created by Marselus Richard on 11/04/23.
//

import Foundation

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
        enume = .planNotReachGoal
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