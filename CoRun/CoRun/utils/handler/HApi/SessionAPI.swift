//
//  SessionAPI.swift
//  CoRun
//
//  Created by Marselus Richard on 08/05/23.
//

import Foundation
import SwiftUI

///HApiREST - API REST Handler
///This contain func that handle directly session related  to endpoint
class SessionAPI: HNetwork{
    //TODO: Error 400
    ///Return all session for a particular userid
    func getUserSession(userId:String, completion:@escaping(Result<[SessionData],ErrorMessage>)->Void){
        let url = "session/\(userId)"
        
        let jsonDictionary: [String:String] = ["":""]
        
        request(requestName: "Get Session", endpointURL: url, method: "GET", body: jsonDictionary){result in
            
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject: [SessionData] = try? JSONDecoder().decode([SessionData].self, from: data){
                        completion(.success(responseObject))
                    }
                    else{
                        print(">> Get User Session failed parsing")
                        completion(.success([SessionData]()))
                    }
                }
            }
        }
    }
    
    ///Post session result for particular sessionid
    func postSessionResult(body:SessionResultData, completion:@escaping(Bool)->Void){
        let url = "session/result"
        
        let jsonDictionary: [String: String] = [
            "id" : String(describing:body.id),
            "resultDate": String(describing:body.resultDate),
            "duration": String(describing:body.duration),
            "distance": String(describing:body.distance),
            "avgBPM": String(describing:body.avgBPM),
            "avgVo2": String(describing:body.avgVo2),
            "stride": String(describing:body.stride),
            "verOsc": String(describing:body.verOsc),
            "elevGain": String(describing:body.elevGain),
            "groundTime": String(describing:body.groundTime),
        ]
        
        request(requestName: "Post session result", endpointURL: url, method: "POST", body: jsonDictionary){result in
            
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success( _):
                do {
                    completion(true)
                }
            }
        }
    }
    
    ///Post session feedback for particular sessionid
    func postSessionFeedback(body:FeedbackData, completion:@escaping(Bool)->Void){
        let url = "session/feedback"
        
        let jsonDictionary: [String:String] = [
            "id": String(describing: body.SessionId),
            "senderId": String(describing: body.SenderId),
            "sentDate": String(describing: body.SentDate),
            "content": String(describing: body.Content),
            "status": String(describing: 0)
        ]
        
        request(requestName: "Post Feedback", endpointURL: url, method: "POST", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success(_):
                completion(true)
            }
        }
    }
    
    ///Get session feedback from particular sessionid
    func getSessionFeedback(sessionId:Int,completion:@escaping(Result<[FeedbackData],ErrorMessage>)->Void){
        let url = "session/feedback/\(sessionId)"
        
        let jsonDictionary: [String:String] = ["":""]
        
        request(requestName: "Get Feedback", endpointURL: url, method: "GET", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([FeedbackData].self, from: data){
                        //Check Decode Result
                        print(">> Get All Feedback: Response count: [" + String(responseObject.count) + "]")
                        completion(.success(responseObject))
                    }
                    else{
                        print(">> Get All Feedback failed parsing")
                    }
                }
            }
        }
    }
    
    func testGetAllSession(completion:@escaping(Result<[rawSession],ErrorMessage>)->Void){
        let url = "session/get-all"
        
        let jsonDictionary: [String: String] = [:]

        request(requestName: "GetAllSession", endpointURL: url, method: "GET", body: jsonDictionary){ result in
            
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                
                let decodedData: [rawSession] = try! JSONDecoder().decode([rawSession].self, from: data)
                
                //Check Decode Result
                print(">> Get All Session: Response count: [" + String(decodedData.count) + "]")
                completion(.success(decodedData))
                
//                do {
//                    ///Do Success Thing
//                    if let responseObject = try? JSONDecoder().decode([rawSession].self, from: data){
//                        //Check Decode Result
//                        print(">> Get All Session: Response count: [" + String(responseObject.count) + "]")
//                        completion(.success(responseObject))
//                    }
//                    else{
//                        print(">> Get All User failed parsing")
//                    }
//                }
            }
        }
        
    }
}
