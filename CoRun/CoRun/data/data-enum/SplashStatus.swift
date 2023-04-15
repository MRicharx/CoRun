//
//  SplashStatus.swift
//  CoRun
//
//  Created by Marselus Richard on 15/04/23.
//

import Foundation

///Class containing splash view status in enum and int
class SplashStatus:ObservableObject{
    ///Define current view state
    /// 0 - Splash,
    /// 1- Signing In,
    /// 2 - Directing to Assestment,
    /// 3 - Checking HealthKit Permission,
    /// else - Directing to Home (All requirement fulfilled)
    @Published var int:Int
    @Published var enume:enumSplashStatus
    
    init(){
        int = 0
        enume = .splash
    }
    
    init(status:Int){
        int = status
        enume = .splash
        
        switch(int){
        case 0:
            enume = .splash
        case 1:
            enume = .signIn
        case 2:
            enume = .assessing
        case 3:
            enume = .healthPermissionRequest
        default :
            enume = .quit
        }
    }
    
    func set(newStatus:enumSplashStatus){
        enume = newStatus
        
        switch(enume){
        case .splash:
            int = 0
        case .signIn:
            int = 1
        case .assessing:
            int = 2
        case .healthPermissionRequest:
            int = 3
        case .quit:
            int = 4
        }
    }
}

enum enumSplashStatus{
    case splash
    case signIn
    case assessing
    case healthPermissionRequest
    case quit
}
