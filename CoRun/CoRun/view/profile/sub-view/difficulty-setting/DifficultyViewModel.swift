//
//  DifficultyViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/06/23.
//

import Foundation
import SwiftUI

class DifficultyViewModel:ObservableObject{
    @Published var distanceDif = ""
    @Published var durationDif = ""
    @Published var paceDif = ""
    @Published var intensityDif = ""
    
    var optList = ["Easy","Normal","Hard"]
    
    func setup(){
        distanceDif = SharedDifficulty.shared.Distance
        durationDif = SharedDifficulty.shared.Duration
        paceDif = SharedDifficulty.shared.Pace
        intensityDif = SharedDifficulty.shared.Intensity
    }
    
    func increase(cur:String)->String{
        switch(cur){
        case "Easy":
            return "Normal"
        case "Normal":
            return "Hard"
        case "Hard":
            return "Easy"
        default:
            return "Normal"
        }
    }
    func decrease(cur:String)->String{
        switch(cur){
        case "Easy":
            return "Hard"
        case "Normal":
            return "Easy"
        case "Hard":
            return "Normal"
        default:
            return "Normal"
        }
    }
}
