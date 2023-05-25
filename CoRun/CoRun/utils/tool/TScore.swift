//
//  TScore.swift
//  CoRun
//
//  Created by Marselus Richard on 15/05/23.
//

import Foundation

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

            ///Minus 1 per 100 meter miss
            if data.Distance > 0{
                wScore -= abs(Int((data.Distance - wk.distance))/100)
            }
            ///Minus 1 per 5 minute miss
            if data.Duration > 0{
                wScore -= abs(Int((data.Duration - wk.duration))/60)
            }
            ///Minus 1 per 10 second miss
            if data.Pace > 0{
                let p = wk.duration/wk.distance
                wScore -= abs(Int((data.Pace - p))/10)
            }
            ///Minus 1 per 1% miss
            if data.Intensity > 0{
                let maxBPM = 220.0 - Double(age)
                let i = wk.avgBPM / maxBPM * 100
                wScore -= abs(Int(data.Intensity) - Int(i))
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
