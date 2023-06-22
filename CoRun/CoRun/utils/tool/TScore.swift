//
//  TScore.swift
//  CoRun
//
//  Created by Marselus Richard on 15/05/23.
//

import Foundation
import SwiftUI

///TScore - Score Tool
///ThisClass contain func to decide the score of data
class TScore{
    ///Compare all workoutdata to session target and
    ///Return the best workout closest to session target
    func scoreSession(data:SessionData,result:[SessionResultData],age:Int)->SessionResultData{
        ///Pick best workout data
        var bestResult = SessionResultData()
        for wk in result{
            var wScore = 100

            ///Minus 1 per x amount meter miss
            if data.Distance > 0{
                var distanceD = 0
                switch(SharedDifficulty.shared.Distance){
                case "Easy":
                    distanceD = 180
                case "Hard":
                    distanceD = 75
                default:
                    distanceD = 100
                }
                
                wScore -= abs(Int((data.Distance - wk.distance))/distanceD)
            }
            ///Minus 1 per x amount of second miss
            if data.Duration > 0{
                var durationD = 0
                switch(SharedDifficulty.shared.Duration){
                case "Easy":
                    durationD = 300
                case "Hard":
                    durationD = 60
                default:
                    durationD = 180
                }
                
                wScore -= abs(Int((data.Duration - wk.duration))/durationD)
            }
            ///Minus 1 per x average second miss
            var paceD = 0
            switch(SharedDifficulty.shared.Pace){
            case "Easy":
                paceD = 60
            case "Hard":
                paceD = 10
            default:
                paceD = 30
            }
            
            if data.Pace > 0{
                let p = wk.duration/wk.distance
                wScore -= abs(Int((data.Pace - p))/paceD)
            }
            
            ///Minus 1 per x amount % miss
            var intensityD = 0
            switch(SharedDifficulty.shared.Intensity){
            case "Easy":
                intensityD = 4
            case "Hard":
                intensityD = 1
            default:
                intensityD = 2
            }
            
            if data.Intensity > 0{
                let maxBPM = 220.0 - Double(age)
                let i = wk.avgBPM / maxBPM * 100
                wScore -= abs(Int(data.Intensity) - Int(i))/intensityD
            }
            
            ///Check if current result better
            if data.Score < wScore{
                bestResult = wk
                bestResult.score = wScore
            }
        }
        return bestResult
    }
    
    ///Return score for completion status
    func validateScore(score:Int)->Int{
        if score>=90{
            return 2
        }
        else if score>=80{
            return 1
        }
        else{
            return 0
        }
    }
}
