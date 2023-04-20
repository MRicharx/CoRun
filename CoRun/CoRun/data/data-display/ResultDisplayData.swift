//
//  ResultDisplayDara.swift
//  CoRun
//
//  Created by Marselus Richard on 20/04/23.
//

import Foundation

class ResultDisplayData:ObservableObject{
    @Published var start:Date
    @Published var end:Date
    
    @Published var distance:Double
    @Published var avgBPM:Double
    @Published var vo2M:Double
    @Published var verticalOsc:Double
    @Published var stride:Double
    @Published var elevGain:Double
    @Published var groundTime:Double
    
    init(){
        start = Date.now
        end = Date.now
        
        distance = 0
        avgBPM = 0
        vo2M = 0
        verticalOsc = 0
        stride = 0
        elevGain = 0
        groundTime = 0
    }
    init(resultData:SessionResultData){
        start = resultData.start ?? Date.now
        end = resultData.end ?? Date.now
        
        distance = resultData.distance ?? -1
        avgBPM = resultData.avgBPM ?? -1
        vo2M = resultData.vo2M ?? -1
        verticalOsc = resultData.verOscillation ?? -1
        stride = resultData.stride ?? -1
        elevGain = resultData.elevGain ?? -1
        groundTime = resultData.groundTime ?? -1
    }
}
