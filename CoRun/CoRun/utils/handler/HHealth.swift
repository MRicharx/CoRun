//
//  HHealth.swift
//  CoRun
//
//  Created by Marselus Richard on 19/03/23.
//

import Foundation
import HealthKit

///HHealth - HealthKit Handler
///This class act as handler for any request related to HealthKit
protocol HHealthProtocol{
    ///Handle request and checking permission
    func permissionHandler(completion: @escaping ((_ status: Bool) -> Void))
    
    ///Return training summary
    func getSummary(completion: @escaping ((_ status: Bool) -> Void))
    
    ///Return All Running Workout data between certain date
    func getWorkoutData(startDate:Date, endDate:Date,completion: @escaping ((_ status: Bool) -> Void))
}
class HHealth{
    let store = HKHealthStore()
    
}

///Define workout measurement for daily mission
enum MeasurementUnit{
    case Pace
    case Distance
    case Intensity
}
