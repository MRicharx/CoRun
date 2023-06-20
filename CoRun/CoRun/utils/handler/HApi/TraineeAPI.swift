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
    func getTrainee(userId:String, completion:@escaping(Result<[TraineeData],ErrorMessage>)->Void){
        let url = "trainee/\(userId)"
        
        let jsonDictionary: [String:String] = [
            "":""
        ]
        
        request(requestName: "Get Trainee", endpointURL: url, method: "GET", body: jsonDictionary){result in
            
            switch result{
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([TraineeData].self, from: data){
                        completion(.success(responseObject))
                    }
                    else{
                        print(">> Get User Trainee failed parsing")
                        completion(.success([TraineeData]()))
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
            "sessionDate": String(describing: body.SessionDate),
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
    
    ///Delete trainee's sesison
    func deleteTraineeSession(sessionId:Int,completion:@escaping(Bool)->Void){
        let url = "trainee/session/\(sessionId)"
        
        request(requestName: "Delete Session", endpointURL: url, method: "DELETE", body: ["":""]){ result in
            switch result{
            case.failure(_):
                print(">> Delete Trainee Session Failed")
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
    
    ///Post Record
    func postRecord(body:RecordData, traineeId:String,completion:@escaping(Bool)->Void){
        let url = "trainee/record"
        
        let jsonDictionary: [String:String] = [
            "id": String(describing: body.recordId),
            "userId": String(describing: traineeId),
            "content": String(describing: body.content),
            "date": String(describing: body.date),
            "writer":String(describing: body.writer)
        ]
        
        request(requestName: "Post Record", endpointURL: url, method: "POST", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case.success(_):
                completion(true)
            }
        }
    }
    
    ///Get Record
    func getRecord(traineeId:String, completion:@escaping(Result<[RecordData],ErrorMessage>)->Void){
        let url = "trainee/record/\(traineeId)"
        
        let jsonDictionary: [String:String] = [
            "":""
        ]
        
        request(requestName: "Get Record", endpointURL: url, method: "GET", body: jsonDictionary){result in
            
            switch result{
            case .failure(let error):
                print(error)
                completion(.failure(error))
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([RecordData].self, from: data){
                        completion(.success(responseObject))
                    }
                    else{
                        print(">> Get User Trainee failed parsing")
                        completion(.success([RecordData()]))
                    }
                }
            }
        }
    }
    
    ///Delete Record
    func deleteRecord(recordId:Int,completion:@escaping(Bool)->Void){
        let url = "trainee/record/\(recordId)"
        
        let jsonDictionary: [String:String] = [
            "":""
        ]
        
        request(requestName: "Delete Record", endpointURL: url, method: "DELETE", body: jsonDictionary){result in
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case.success(_):
                completion(true)
            }
        }
    }
    
//    ///Return trainee session
//    func getTraineeSession(traineeId:String, completion:@escaping(Result<[SessionData],ErrorMessage>)->Void){
//        let url = "trainee/session?trainee=\(traineeId)"
//        
//        let jsonDictionary: [String:String] = [
//            "":""
//        ]
//        
//        request(requestName: "Get Session", endpointURL: url, method: "GET", body: jsonDictionary){result in
//            
//            switch result{
//            case .failure(let error):
//                print(error)
//                completion(.failure(error))
//            case .success(let data):
//                do {
//                    ///Do Success Thing
//                    if let responseObject: [SessionData] = try? JSONDecoder().decode([SessionData].self, from: data){
//                        completion(.success(responseObject))
//                    }
//                    else{
//                        print(">> Get User Session failed parsing")
//                        completion(.success([SessionData]()))
//                    }
//                }
//            }
//        }
//    }
//    ///Get session feedback from trainee session
//    func getTraineeSessionFeedback(sessionId:Int, completion:@escaping([FeedbackData])->Void){
//        let url = "trainee/session-feedback?session=\(sessionId)"
//
//        let jsonDictionary: [String:String] = [
//            "":""
//        ]
//
//        request(requestName: "Get Trainee Session Feedback", endpointURL: url, method: "GET", body: jsonDictionary,isPrintStatus: true){result in
//            switch result{
//            case .failure(let error):
//                print(error)
//                completion([FeedbackData]())
//            case .success(let data):
//                do {
//                    ///Do Success Thing
//                    if let responseObject = try? JSONDecoder().decode([FeedbackData].self, from: data){
//                        //Check Decode Result
//                        print(">> Get Trainee Session Feedback: Response count: [" + String(responseObject.count) + "]")
//                        completion(responseObject)
//                    }
//                    else{
//                        print(">> Get All Feedback failed parsing")
//                    }
//                }
//            }
//        }
//    }
//
//    ///Post session feedback to trainee session
//    func postTraineeSessionFeedback(body:FeedbackData,completion:@escaping(Bool)->Void){
//        let url="trainee/session-feedback"
//
//        let jsonDictionary: [String:String] = [
//            "id": String(describing: body.SessionId),
//            "senderId": String(describing: body.SenderId),
//            "sentDate": String(describing: body.SentDate),
//            "content": String(describing: body.Content),
//            "status": String(describing: 0)
//        ]
//
//        request(requestName: "Post Trainee Session Feedback", endpointURL: url, method: "POST", body: jsonDictionary){ result in
//            switch result{
//            case .failure(let error):
//                print(error)
//                completion(false)
//            case .success(_):
//                completion(true)
//            }
//        }
//    }
//
}
