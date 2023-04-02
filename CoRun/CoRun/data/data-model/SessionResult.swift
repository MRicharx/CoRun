//
//  Session.swift
//  CoRun
//
//  Created by Marselus Richard on 02/04/23.
//

import Foundation

///Define an object that contain result of workout
struct SessionResult : Decodable{
    var start:Date?
    var end:Date?
    ///Distance run in meter
    var distance:Double?
    ///Average beat in hertz
    var avgBPM:Double?
    ///Volume in lit
    var vo2M:Double?
    ///Vertical Oscillation in meter
    var verOscillation:Double?
    ///Stride in meter
    var stride:Double?
    ///Elevation gain in meter
    var elevGain:Double?
    ///Duration of ground time in second
    var groundTime:Double?

    init(start: Date? = nil, end: Date? = nil, distance: Double? = nil, avgBPM: Double? = nil, vo2M: Double? = nil, verOscillation: Double? = nil, stride: Double? = nil, elevGain: Double? = nil, groundTime: Double? = nil) {
        self.start = start
        self.end = end
        self.distance = distance
        self.avgBPM = avgBPM
        self.vo2M = vo2M
        self.verOscillation = verOscillation
        self.stride = stride
        self.elevGain = elevGain
        self.groundTime = groundTime
    }
}

