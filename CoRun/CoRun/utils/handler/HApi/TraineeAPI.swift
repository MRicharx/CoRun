//
//  TraineeAPI.swift
//  CoRun
//
//  Created by Marselus Richard on 08/05/23.
//

import Foundation

///HApiREST - API REST Handler
///This contain func that handle directly trainee related  to endpoint
class TraineeAPI:HNetwork{
    ///Return all user trainee
    func getTrainee(userId:String, completion:@escaping([ProfileData])->Void){
        let url = "trainee?coach=\(userId)"
        
        let jsonDictionary: [String:String] = [
            "":""
        ]
        
        request(requestName: "Get Trainee", endpointURL: url, method: "GET", body: jsonDictionary,isPrintStatus: true){result in
            
            switch result{
            case .failure(let error):
                print(error)
                completion([ProfileData]())
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([ProfileData].self, from: data){
                        completion(responseObject)
                    }
                    else{
                        print(">> Get User Trainee failed parsing")
                    }
                }
            }
        }
    }
    
    ///Return trainee session
    func getTraineeSession(traineeId:String, completion:@escaping([SessionData])->Void){
        let url = "trainee/session?trainee=\(traineeId)"
        
        let jsonDictionary: [String:String] = [
            "":""
        ]
        
        request(requestName: "Get Session", endpointURL: url, method: "GET", body: jsonDictionary,isPrintStatus: true){result in
            
            switch result{
            case .failure(let error):
                print(error)
                completion([SessionData]())
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([SessionData].self, from: data){
                        completion(responseObject)
                    }
                    else{
                        print(">> Get User Session failed parsing")
                    }
                }
            }
        }
    }
    
    ///Post session for trainee
    func postTraineeSession(body:SessionData, completion:@escaping(Bool)->Void){
        let url = "trainee/session"
        
        let jsonDictionary: [String:String] = [
            "id": String(describing: body.UserId),
            "coachId": String(describing: body.CoachId),
            "date": String(describing: body.SessionDate),
            "name": String(describing: body.Name),
            "description": String(describing: body.Description),
            "status": String(describing: body.Status),
            "duration": String(describing: body.Duration),
            "distance": String(describing: body.Distance),
            "pace": String(describing: body.Pace),
            "intensity": String(describing: body.Intensity)
        ]
        
        request(requestName: "Post session", endpointURL: url, method: "POST", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case.success(_):
                completion(true)
            }
        }
    }
    
    ///Get session feedback from trainee session
    func getTraineeSessionFeedback(sessionId:Int, completion:@escaping([FeedbackData])->Void){
        let url = "trainee/sessions-feedback?session=\(sessionId)"
        
        let jsonDictionary: [String:String] = [
            "":""
        ]
        
        request(requestName: "Get Trainee Session Feedback", endpointURL: url, method: "GET", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion([FeedbackData]())
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([FeedbackData].self, from: data){
                        //Check Decode Result
                        print(">> Get Trainee Session Feedback: Response count: [" + String(responseObject.count) + "]")
                        completion(responseObject)
                    }
                    else{
                        print(">> Get All Feedback failed parsing")
                    }
                }
            }
        }
    }
    
    ///Post session feedback to trainee session
    func postTraineeSessionFeedback(body:FeedbackData,completion:@escaping(Bool)->Void){
        let url="trainee/session-feedback"
        
        let jsonDictionary: [String:String] = [
            "id": String(describing: body.id),
            "senderId": String(describing: body.senderID),
            "sentDate": String(describing: body.sentDate),
            "content": String(describing: body.content),
            "status": String(describing: 0)
        ]
        
        request(requestName: "Post Trainee Session Feedback", endpointURL: url, method: "POST", body: jsonDictionary){ result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success(_):
                completion(true)
            }
        }
    }
    
    ///Dismiss trainee
    func dismissTrainee(traineeId:String, coachId:String, completion:@escaping(Bool)->Void){
        let url = "trainee/dismiss"
        
        let jsonDictionary: [String:String] = [
            "traineeId" : String(describing: traineeId),
            "coachId" : String(describing: coachId)
        ]
        
        request(requestName: "Dismiss Trainee", endpointURL: url, method: "DELETE", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success(_):
                completion(true)
            }
        }
    }
    
    ///Accept Trainee
    func acceptTrainee(traineeId:String, coachId:String, completion:@escaping(Bool)->Void){
        let url = "trainee/accept"
        
        let jsonDictionary: [String:String] = [
            "id" : String(describing: traineeId),
            "coachId" : String(describing: coachId)
        ]
        
        request(requestName: "Accept Trainee", endpointURL: url, method: "PUT", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success(_):
                completion(true)
            }
        }
    }
    
    ///Decline Trainee
    func declineTrainee(traineeId:String, coachId:String, completion:@escaping(Bool)->Void){
        let url = "trainee/decline"
        
        let jsonDictionary: [String:String] = [
            "id" : String(describing: traineeId),
            "coachId" : String(describing: coachId)
        ]
        
        request(requestName: "Decline Trainee", endpointURL: url, method: "PUT", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success(_):
                completion(true)
            }
        }
    }
}
