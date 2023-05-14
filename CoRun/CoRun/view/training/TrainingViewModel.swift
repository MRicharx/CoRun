//
//  TrainingViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation

class TrainingViewModel:ObservableObject{
    @Published var pubSes = [SessionData]()
    private var newResult = SessionResultData()
    private var bufferSes = [SessionData]()
    private var bufferWorkout = [SessionResultData]()
    
    @Published var updateResult = false
    
    private let uapi = UserAPI()
    private let sapi = SessionAPI()
    private let health = HHealth()
    
    init(){
    }
    
    ///Load buffer data to published data
    func loadBuffer(){
        pubSes = bufferSes
        print(">> TrainingViewModel: Published Session: Item Count: \(pubSes.count)")
    }
    
    ///Post new session result
    func postResult() async{
        await withCheckedContinuation{ posting in
            sapi.postSessionResult(body: newResult){success in
                if success{
                    print(">> TrainingViewModel: postResult: Success")
                }
                else{
                    print(">> TrainingViewModel: postResult: Failed")
                }
                posting.resume()
            }
        }
    }
    
    ///Match workout with session
    func matchSession(age:Int){
        ///Find today session
        for data in bufferSes{
            let date = TDate().stringToDate(date: data.SessionDate,format: "YYYY-MM-dd")
            if TDate().compare(first: date, second: Date.now, format: "YYYY-MM-dd"){
    
                ///Pick best workout data
                var bestResult = SessionResultData()
                for wk in bufferWorkout{
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
                    ///Minus 1 per 0.5% miss
                    if data.Intensity > 0{
                        let i = Double(Int(wk.avgBPM) / (220 - age) * 100)
                        wScore -= 2 * abs(Int(data.Intensity) - Int(i))
                    }
    
                    ///Check if current result better
                    if data.Score < wScore{
                        bestResult = wk
                        bestResult.score = wScore
                    }
                }
    
    
                ///Compare existing result with new best result score
                if data.Score < bestResult.score{
                    updateResult = true

                    print(">> TrainingViewModel: Found better result: with score: [\(bestResult.score)]")

                    newResult = bestResult
                    newResult.id = data.SessionId
                }
                
            }
        }
    }
    
    ///Load session from data base to buffer
    func getSession() async{
        let id = SharedToken.shared.SignInToken
        
        await withCheckedContinuation{continuation in
            sapi.getUserSession(userId: id){ result in
                switch result{
                case .failure(_):
                    print(">> TrainingViewModel: Get Session Error")
                case .success(let data):
                    self.bufferSes = data
                }
                
                continuation.resume()
            }
        }
    }
    
    ///Check result from healthkit and update result on session
    func getWorkoutData() async{
        ///Define today start date
        let start = TDate().getStartDate()
        ///Define today end date
        let end = TDate().getEndDate()
        
        await withCheckedContinuation{ getWorkout in
            health.getSessionResult(start: start, end: end){ result in
                
                self.bufferWorkout = result
                getWorkout.resume()
            }
        }
    }
}
