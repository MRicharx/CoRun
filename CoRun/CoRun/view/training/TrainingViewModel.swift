//
//  TrainingViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation

class TrainingViewModel:ObservableObject{
    @Published var pubSes = [SessionData]()
    private var bufferSes = [SessionData]()
    
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
    func matchSessionWithHealth() async{
        //TODO: Implement this function
//        await withCheckedContinuation{continuation in
//            health
//        }
    }
}
