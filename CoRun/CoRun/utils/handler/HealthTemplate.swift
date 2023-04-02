//
//  HealthTemplate.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation


//
//  HealthKitUtils.swift
//  Friendsisca
//
//  Created by Marselus Richard on 17/10/22.
//

import Foundation
import HealthKit

///Define workout type for daily mission
enum WorkoutType:CaseIterable{
    case Core,
         Cycling,
         Running,
         Swimming,
         Walking,
         ///State Daily Login Condition
         Login,
         All
}

///Define workout measurement for daily mission
enum MeasurementUnit{
    case Minute,
         Second,
         Calories
}

func defineWorkoutType(type:String)->WorkoutType{
    ///Figure Workout Type
    switch(type){
    case "Badminton":
        return WorkoutType.Core
    case "Swimming":
         return WorkoutType.Swimming
    case "Cycling":
        return WorkoutType.Cycling
    case "Walking":
        return WorkoutType.Walking
    case "Login":
        ///Will return 1 for daily login
        return WorkoutType.Login
    default:
        return WorkoutType.All
    }
}

func defineMeasurementUnit(unit:String)->MeasurementUnit{
    switch(unit){
    case "seconds":
        return MeasurementUnit.Second
    case "minutes":
        return MeasurementUnit.Minute
    default:
        return MeasurementUnit.Calories
    }
}

class HealthKitUtils{
    let store = HKHealthStore()

    ///Check and or Show Request Access For HealthKit
    func requestPermission(completion: @escaping ((_ status: Bool) -> Void))  {
        let write: Set<HKSampleType> = []
        let read: Set = [
            .workoutType(),
            HKSeriesType.workoutType(), //Workout Type
            HKQuantityType.init(HKQuantityTypeIdentifier.activeEnergyBurned), //Calorie burned
            HKQuantityType.init(HKQuantityTypeIdentifier.appleExerciseTime) //Exercise Time
        ]

        store.requestAuthorization(toShare: write, read: read) { (success, error) in
            if !success {
                // Handle the error here.
                completion(false)
            }else{
                completion(true)
            }
        }
    }//Check n Request HealthKit Permission

    ///Get User Daily Burned Calories with Date as parameter
    func getBurnedCaloriesByDate(startDate:String,endDate:String,completion:@escaping(Double)->Void){
        let start = TimeHandler.init().stringToDate(date: startDate)
        let end = TimeHandler.init().stringToDate(date: endDate)

        guard let energyConsumed = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the quantity type ***")
        }

        let today = HKQuery.predicateForSamples(withStart: start, end: end, options: [])

        let query = HKStatisticsQuery(quantityType: energyConsumed, quantitySamplePredicate: today, options: .cumulativeSum) { (query, statisticsOrNil, errorOrNil) in
            guard let statistics = statisticsOrNil else {
                // Handle any errors here.
                print(">> getBurnedCaloriesByDate() Query Resulted With Nil")
                return completion(0.0)
            }

            let sum = statistics.sumQuantity()
            let totalCaloriesConsumed = sum?.doubleValue(for: HKUnit.largeCalorie())
            print(">> getBurnedCaloriesByDate() Query Resulted With "+String(totalCaloriesConsumed ?? 0.0))

            // Update your app here.
            completion(totalCaloriesConsumed ?? 0.0)
        }
        print("getBurnedCaloriesByDate Query Called")
        store.execute(query)
    }


    ///Get User Daily Burned Calories as Double
    func getDayBurnedCalories(completion: @escaping ((_ totalEnergy: Double) -> Void)){
        guard let energyConsumed = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned) else {
            // This should never fail when using a defined constant.
            fatalError("*** Unable to get the quantity type ***")
        }

        let calendar = Calendar(identifier: .gregorian)
        let now = Date()

        ///Set Predicate from today at midnight
        let startDate = calendar.startOfDay(for: now)
        let endDate = now

        let today = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])

        let query = HKStatisticsQuery(quantityType: energyConsumed, quantitySamplePredicate: today, options: .cumulativeSum) { (query, statisticsOrNil, errorOrNil) in
            guard let statistics = statisticsOrNil else {
                // Handle any errors here.
                print(">> getDayBurnedCalories() Query Resulted With Nil")
                return completion(0.0)
            }

            let sum = statistics.sumQuantity()
            let totalCaloriesConsumed = sum?.doubleValue(for: HKUnit.largeCalorie())
            print(">> getDayBurnedCalories() Query Resulted With "+String(totalCaloriesConsumed ?? 0.0))

            // Update your app here.
            completion(totalCaloriesConsumed ?? 0.0)

            // The results come back on an anonymous background queue.
            // Dispatch to the main queue before modifying the UI.

            DispatchQueue.main.async {
                // Update the UI here.

            }
        }
        print("GetCaloriesBurnt Query Called")
        store.execute(query)
    }//Get Calories burnt this day

    ///Get Workout Data From Specific Workout Type as Enum Parameter and return it as [HKWorkout]
    func getWorkoutData(workoutType:WorkoutType, completion: @escaping ((_ totalTime: [HKWorkout]?) -> Void)){
        //let startDate = Calendar.current.date(byAdding: .day, value: -30, to: Date()) //Test Syntax
        let calendar = Calendar(identifier: .gregorian)
        let now = Date()

        let startDate = calendar.startOfDay(for: now) //Set Predicate from today at midnight
        let endDate = now
        var HKWorkoutType = HKQuery.predicateForWorkouts(with: .walking)

        //Set Workout Type as Parameter
        switch workoutType{
        case .Core:
            HKWorkoutType = HKQuery.predicateForWorkouts(with: .coreTraining)
        case .Cycling:
            HKWorkoutType = HKQuery.predicateForWorkouts(with: .cycling)
        case .Running:
            HKWorkoutType = HKQuery.predicateForWorkouts(with: .running)
        case .Swimming:
            HKWorkoutType = HKQuery.predicateForWorkouts(with: .swimming)
        case .Walking:
            HKWorkoutType = HKQuery.predicateForWorkouts(with: .walking)
        default:
            HKWorkoutType = HKQuery.predicateForWorkouts(with: .walking)
        }

        //Set Query Parameter
        let predicateDate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions())
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [
            HKWorkoutType,
            predicateDate
        ])

        //Define Query
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: compound, limit: HKObjectQueryNoLimit, sortDescriptors: [.init(keyPath: \HKSample.startDate, ascending: false)], resultsHandler: { query, samples, error in
            guard let samples = samples else {
                fatalError("*** Invalid State: This can only fail if there was an error. ***")
            }
            guard let workouts = samples as? [HKWorkout] else {
                print(">> getWorkoutData(\(workoutType)) Query Resulted With Nil")
                return
            }

            print(">> getWorkoutData(\(workoutType) Query Resulted With "+String(workouts.count)+" data")
            completion(workouts)
        })
        //Define Query - END

        //Call Query
        print("GetWorkoutData Query Called")
        store.execute(query)
    }//Get Workout Data from Specific Type


    ///Get Workout Duration from Specific Workout Type as Enum Parameter and return duration as Int in Seconds
    func getWorkoutTime(workoutType:WorkoutType, completion: @escaping ((_ totalTime: Int) -> Void)){
        var totalDuration=0
        getWorkoutData(workoutType: workoutType){ workoutList in
            workoutList?.forEach{data in
                totalDuration+=Int(data.duration)
            }
            print(">> getWorkoutTime(\(workoutType)) Query Resulted With "+String(totalDuration)+" seconds")
            completion(totalDuration)
        }
    }//Get Workout Duration for specific workout in Second Format

//    ///Get Total Burned calories on numbers of workout
//    func getWorkoutCal(workoutType:WorkoutType, completion:@escaping(Int)->Void){
//        var totalCal=0
//        getWorkoutData(workoutType:workoutType){workoutList in
//            workoutList?.forEach{data in
//                totalCal += Int(data.ene)
//            }
//            print(">> getWorkoutTime(\(workoutType)) Query Resulted With "+String(totalCal)+" Cal")
//            completion(totalCal)
//        }
//    }

//    ///Get Workout Duration from Specific Workout Type as Enum Parameter and return duration as Int in Seconds
//    func getWorkoutDistance(workoutType:WorkoutType, completion: @escaping ((_ totalDistance: Int) -> Void)){
//        var totalDistance=0
//
//        getWorkoutData(workoutType: workoutType){ workoutList in
//            workoutList?.forEach{data in
//                totalDistance+=Int(data.)
//            }
//            print(">> getWorkoutDistance() Query Resulted With "+String(totalDistance)+" seconds")
//            completion(totalDistance)
//        }
//    }//Get Workout Duration for specific workout in Second Format


}
