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

    ///Handle request and checking permission
    func requestPermission(completion: @escaping ((_ status: Bool) -> Void))  {
        ///Define what will be write on healthkit
        let write: Set<HKSampleType> = []
        ///Define what will be read from healthkit
        let read: Set = [
            .workoutType(),
            HKSeriesType.workoutType(), //Workout Type
//            HKQuantityType.init(HKQuantityTypeIdentifier.appleExerciseTime), //Exercise Time
            HKQuantityType.init(HKQuantityTypeIdentifier.distanceWalkingRunning), //Distance
            
            HKQuantityType.init(HKQuantityTypeIdentifier.heartRate), //Heart Rate
            HKQuantityType.init(HKQuantityTypeIdentifier.vo2Max), //VO2Max
            HKQuantityType.init(HKQuantityTypeIdentifier.runningVerticalOscillation), //Vertical Ocillation
            HKQuantityType.init(HKQuantityTypeIdentifier.runningStrideLength), //Stride
            HKQuantityType.init(HKQuantityTypeIdentifier.runningGroundContactTime) //Ground Time
        ]

        store.requestAuthorization(toShare: write, read: read) { (success, error) in
            if !success {
                // Handle the error here.
                print(">> HHealth: Permission Handler Resulted with: ERROR")
                completion(false)
            }else{
                completion(true)
            }
        }
    }//Check n Request HealthKit Permission
    
    ///Return All Session Result from workout data
    func getSessionResult(start:Date, end:Date,completion: @escaping ((_ data: [SessionResultData]) -> Void)){
        
        ///Define returned array
        var session = [SessionResultData]()
        
        getWorkoutData(start: start, end: end){ workoutData in
            workoutData?.forEach{ data in
                
                ///Define Workout Meta data
                let meta = data.metadata
                let elev = meta?["HKElevationAscended"] as? HKQuantity
                
                let time = TDate().dateToString(date:  data.startDate)
                
                ///Append data to returned array
                session.append(SessionResultData(
                    id: 0,
                    resultDate: time,
                    duration: data.duration,
                    distance: data.statistics(for: HKQuantityType.init(HKQuantityTypeIdentifier.distanceWalkingRunning))?.sumQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0,
                    avgBPM: (data.statistics(for: HKQuantityType.init(HKQuantityTypeIdentifier.heartRate))?.averageQuantity()?.doubleValue(for: HKUnit.hertz()) ?? 00) * 60,
                    avgVo2: data.statistics(for: HKQuantityType.init(HKQuantityTypeIdentifier.vo2Max))?.averageQuantity()?.doubleValue(for: HKUnit.liter()) ?? 0,
                    stride: data.statistics(for: HKQuantityType.init(HKQuantityTypeIdentifier.runningStrideLength))?.averageQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0,
                    verOsc: data.statistics(for: HKQuantityType.init(HKQuantityTypeIdentifier.runningVerticalOscillation))?.averageQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0,
                    elevGain: elev?.doubleValue(for: HKUnit.meter()) ?? 0,
                    groundTime: data.statistics(for: HKQuantityType.init(HKQuantityTypeIdentifier.runningGroundContactTime))?.averageQuantity()?.doubleValue(for: HKUnit.second()) ?? 0,
                    score: 0
                ))
            }
            
            ///Query completed
            if(session.isEmpty){
                print(">> HHealth: getSessionResult Resulted with NIL")
            }
            completion(session)
        }
    }
    
    ///Return all workout data with date  predicate
    private func getWorkoutData(start:Date, end:Date,completion: @escaping ((_ result: [HKWorkout]?) -> Void)){
        
        ///Define workout type predicate
//        let type = HKQuery.predicateForWorkouts(with: .running)
        let type = HKQuery.predicateForWorkouts(with: .running)
        ///Define workout time interval predicate
        let interval = HKQuery.predicateForSamples(withStart: start, end: end)
        
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [
            type,
            interval
        ])
        
        ///Define Query detail
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: compound, limit: HKObjectQueryNoLimit, sortDescriptors: [.init(keyPath: \HKSample.startDate, ascending: true)], resultsHandler: { query, samples, error in
            
            guard samples != nil else {
                fatalError(">> HHealth: getWorkoutData resulted with: FATAL ERROR")
            }
            
            guard let workouts = samples as? [HKWorkout] else {
                print(">> HHealth: getWorkoutData Resulted With Nil")
                return
            }
            
            print(">> HHealth: getWorkoutData Resulted With  "+String(workouts.count)+" data")
            
            ///Return query result
            completion(workouts)
        })

        
        ///Call query
        store.execute(query)
    }
}

/////Define workout measurement for daily mission
//enum MeasurementUnit{
//    case Pace
//    case Distance
//    case Intensity
//}
