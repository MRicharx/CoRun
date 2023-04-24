//
//  DashboardDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 24/04/23.
//

import Foundation

class DashboardDisplayData:ObservableObject{
    ///Define distance target
    @Published var title = ""
    ///Define distance target
    @Published var targetDistance = ""
    ///Define pace target in minute
    @Published var targetPaceMin = ""
    ///Define pace target in second
    @Published var targetPaceSec = ""
    ///Define intensity target
    @Published var targetIntensity = ""
    ///Define duration target in hour
    @Published var targetDurationHour = ""
    ///Define duration target in min
    @Published var targetDurationMin = ""
    ///Define session desc
    @Published var desc = ""
    
    init(){
        
    }
}
