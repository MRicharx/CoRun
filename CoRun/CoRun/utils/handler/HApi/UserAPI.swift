//
//  HApi.swift
//  CoRun
//
//  Created by Marselus Richard on 19/03/23.
//

import Foundation
import SwiftUI

///UserAPI - API REST Handler
///This contain func that handle directly user related  to endpoint
class UserAPI : HNetwork{
    ///Sign in to account with uuid from appleid and appleid email
    ///if account did not exist will create new one
    func SignInWithAppleID(body: SignInData, completion:@escaping(Result<ProfileData, ErrorMessage>)->Void){
        let url = "user/sign-in"
        
        let jsonDictionary: [String: String] = [
            "uuid": String(describing: body.uuid),
            "email": String(describing: body.email)
        ]
        
        request(requestName: "SignIn", endpointURL: url, method: "POST", body: jsonDictionary){ result in
            
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([ProfileData].self, from: data) {
                        completion(.success(responseObject[0]))
                    }
                }
            }
        }
    }
    
    ///Returning single instance of user data based on user id
    func GetUserData(userId: String, completion:@escaping(Result<ProfileData,ErrorMessage>)->Void){
        let url = "user/get-profile?user=\(userId)"
        
        let jsonDictionary: [String: String] = [
            "":""
        ]
        
        request(requestName: "Get User Data", endpointURL: url, method: "GET", body: jsonDictionary){ result in
            
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([ProfileData].self, from: data){
                        if(responseObject.count > 0){
                            completion(.success(responseObject[0]))
                        }
                        else{
                            completion(.success(ProfileData()))
                        }
                    }
                    else{
                        print(">> Get User Data failed parsing")
                    }
                }
            }
        }
        
    }
    
    ///Updating user data on endpoint
    func UpdateUserData(body: ProfileData, completion:@escaping(Bool)->Void){
        let url = "user/update-profile"
        
        let jsonDictionary: [String:String] = [
            "id": String(body.UserId),
            "username": String(body.Username),
            "weight": String(body.Weight),
            "height": String(body.Height),
            "birthday": String(body.Birthday),
        ]
        
        request(requestName: "Update user Data", endpointURL: url, method: "PUT", body: jsonDictionary){ result in
            
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
    
    ///Sending request to coach
    func SendCoachRequest(userId:String, coachId:String, completion:@escaping(Bool)->Void){ let url = "user/request-coach"
        
        let jsonDictionary: [String:String] = [
            "id": String(describing: userId),
            "coachId": String(describing: coachId)
        ]
     
        request(requestName: "Send Coach Request", endpointURL: url, method: "POST", body: jsonDictionary){ result in
            
            switch result{
            case .failure(let error):
                print(error)
                completion(false)
            case .success(_):
                do {
                    completion(true)
                }
            }
        }
    }
    
    func testGetAllUser(completion:@escaping(Result<[ProfileData],ErrorMessage>)->Void){
        let url = "user/get-all-user"
        
        let jsonDictionary: [String: String] = [:]

        request(requestName: "GetAllUser", endpointURL: url, method: "GET", body: jsonDictionary, isPrintStatus: true){ result in
            
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    ///Do Success Thing
                    if let responseObject = try? JSONDecoder().decode([ProfileData].self, from: data){
                        //Check Decode Result
                        print(">> Get All User: Response count: [" + String(responseObject.count) + "]")
                        completion(.success(responseObject))
                    }
                    else{
                        print(">> Get All User failed parsing")
                    }
                }
            }
        }
        
    }
}
