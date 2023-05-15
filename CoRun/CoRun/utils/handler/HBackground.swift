//
//  HBackground.swift
//  CoRun
//
//  Created by Marselus Richard on 15/05/23.
//

import Foundation

class HBackground{
    let id = SharedToken.shared.SignInToken
    
    let uapi = UserAPI()
    let sapi = SessionAPI()
    let health = HHealth()
    let group = DispatchGroup()
    
    var today = SessionData()
    var workout = [SessionResultData]()
    var age = 0
    
    func syncWorkout(completion:@escaping()->Void) {
        //MARK: Load Session
        group.enter()
        sapi.getUserSession(userId: id){result in
            switch result{
            case.failure(_):
                print(">> Background sync: Get Session Failed")
            case .success(let session):
                ///Find today session
                for data in session{
                    let date = TDate().stringToDate(date: data.SessionDate,format: "YYYY-MM-dd")
                    if TDate().compare(first: date, second: Date.now, format: "YYYY-MM-dd"){
                        
                        ///Pick today session
//                        today = data
//                        print(">> Background sync: Session: \(data.SessionDate)")
                        self.group.leave()
                    }
                }
            }
        }
        
        //MARK: Load Workout
        ///Define today start date
        let start = TDate().getStartDate()
        ///Define today end date
        let end = TDate().getEndDate()
        group.enter()
        health.getSessionResult(start: start, end: end){result in
            self.workout = result
//            print(">> Background sync: Workout: \(workout.count)")
            self.group.leave()
        }
        
        //MARK: Load User Data
        group.enter()
        uapi.GetUserData(userId: id){result in
            switch result{
            case .failure(_):
                print(">> Background sync: Get User Failed")
            case .success(let data):
                let bd = TDate().stringToDate(date: data.Birthday)
                self.age = TDate().getUserAge(birth: bd)
//                print(">> Background sync: Age: \(age)")
                self.group.leave()
            }
            
        }
        
        //MARK: Sync Session with workout
        group.notify(queue: .main) {
            ///Get best workout out session closest to session target
            var bestResult = TScore().scoreSession(data: self.today, result: self.workout, age: self.age)
            
            if self.today.Score < bestResult.score{
                bestResult.id = self.today.SessionId
                self.sapi.postSessionResult(body: bestResult){success in
                    if success{
                        print(">> Background sync: Posting Result: Success")
                    }
                    else{
                        print(">> Background sync: Posting Result: Failed")
                    }
                    completion()
                }
            }
        }
    }
}
