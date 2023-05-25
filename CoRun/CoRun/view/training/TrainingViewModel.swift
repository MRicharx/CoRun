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
            let date = TDate().stringToDate(date: data.SessionDate,format: "yyyy-MM-dd")
            
            if TDate().compare(first: date, second: Date.now, format: "yyyy-MM-dd"){
                
                ///Get best workout out session closest to session target
                let bestResult = TScore().scoreSession(data: data, result: bufferWorkout, age: age)
                
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
