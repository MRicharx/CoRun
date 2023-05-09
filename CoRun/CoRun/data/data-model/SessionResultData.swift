//
//  Session.swift
//  CoRun
//
//  Created by Marselus Richard on 02/04/23.
//

import Foundation

///Define an object that contain result of workout
struct SessionResultData : Codable{
    ///session id
    var id = 0
    ///result date
    var resultDate = ""
    ///Duration run in second
    var duration = 0.0
    ///Distance run in meter
    var distance = 0.0
    ///Average beat in hertz
    var avgBPM = 0.0
    ///Volume in lit
    var avgVo2 = 0.0
    ///Stride in meter
    var stride = 0.0
    ///Vertical Oscillation in meter
    var verOsc = 0.0
    ///Elevation gain in meter
    var elevGain = 0.0
    ///Duration of ground time in second
    var groundTime = 0.0

    init(id: Int = 0, resultDate: String = "", duration: Double = 0.0, distance: Double = 0.0, avgBPM: Double = 0.0, avgVo2: Double = 0.0, stride: Double = 0.0, verOsc: Double = 0.0, elevGain: Double = 0.0, groundTime: Double = 0.0) {
        self.id = id
        self.resultDate = resultDate
        self.duration = duration
        self.distance = distance
        self.avgBPM = avgBPM
        self.avgVo2 = avgVo2
        self.stride = stride
        self.verOsc = verOsc
        self.elevGain = elevGain
        self.groundTime = groundTime
    }
}

