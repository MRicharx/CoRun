//
//  TargetType.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

///Class containing session completion status in enum and int
///Define status
///0 - Duration,
///1 - Distance,
///2 - Pace,
///3 - Intensity,
///4 - Free
class TargetType:ObservableObject{
    @Published var int:Int
    @Published var enume:enumTargetType
    
    init(){
        int = 0
        enume = .free
    }
    
    init(status:Int){
        int = status
        enume = .free
        
        switch(int){
        case 0:
            enume = .duration
        case 1:
            enume = .distance
        case 2:
            enume = .pace
        case 3 :
            enume = .intensity
        default:
            enume = .free
        }
    }
    
    func set(newStatus:enumTargetType){
        enume = newStatus
        
        switch(enume){
        case .duration:
            int = 0
        case .distance:
            int = 1
        case .pace:
            int = 2
        case .intensity:
            int = 3
        case .free:
            int = 4
        }
    }
}

enum enumTargetType{
    case duration
    case distance
    case pace
    case intensity
    case free
}

