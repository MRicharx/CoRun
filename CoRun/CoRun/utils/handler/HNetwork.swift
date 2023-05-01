//
//  HNetwork.swift
//  CoRun
//
//  Created by Marselus Richard on 19/03/23.
//

import Foundation
import SwiftUI

///HNetwork - Network Handler
///This class act as super class for class member in HApi
class HNetwork{
    ///Account token
    var token = ""
    ///Endpoint base url
    let baseURL = "http://http://203.194.113.74/api/"
    
    init(){
        self.token = SharedToken.shared.SignInToken
    }
    
    ///Use when send request to API
    ///Parameter will consist of:
    ///requestName, endpoint url, request method, token if available, is Print Status, request parameter
    func request(requestName:String,endpointURL: String, method: String, withToken: String = "", isPrintStatus:Bool = false, parameters: [String: String], completion: @escaping (Result<Data, ErrorMessage>) -> ()){
        let urlString = self.baseURL+endpointURL
        ///Prevent nil url
        guard let url=URL(string: urlString)else{
            ///Print INVALID URL
            if(isPrintStatus){
                print(">> [" + requestName + "] : URL INVALID")
            }
            return
        }
        
        ///Print Request Sent Mark
        if(isPrintStatus){
            print(">> [" + requestName + "] URL : " + urlString)
        }
        
        ///Translate request
        var request = URLRequest(url:url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //TODO: Set token
//        if (!withToken.isEmpty) {
//            request.setValue(withToken, forHTTPHeaderField: "maccrotoken")
//        }
        
        ///Define request method
        if method == "GET"{
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let responseCode = (response as? HTTPURLResponse)?.statusCode {
                    guard let responseData = data, error == nil else {
                        ///Print URL error
                        if(isPrintStatus){
                            print(">> [" + requestName + "] : resulted with : ERROR")
                        }
                        return
                    }
                    
                    ///Print response code
                    if(isPrintStatus){
                        print(">> [" + requestName + "] : resulted with : " + String(responseCode))
                    }

                    ///Handle response
                    if (responseCode == 200 || responseCode == 201) {
                        completion(.success(responseData))
                    }
                    //TODO: Token Handler
                    else if responseCode == 401 {
//                        AppSetting.shared.token = ""
//                        AppSetting.shared.tokenPushNotif = ""
                    }
                    else {
                        do {
                            if let responseObject = try? JSONDecoder().decode(ErrorMessage.self, from: responseData) {
                                completion(.failure(responseObject))
                            }
                        }
                    }
                }
            }
            task.resume()
        }
        else{
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)

            let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
                if let responseCode = (response as? HTTPURLResponse)?.statusCode {
                    guard let responseData = data, error == nil else {
                        ///Print URL error
                        if(isPrintStatus){
                            print(">> [" + requestName + "] : resulted with : ERROR")
                        }
                        return
                    }
                    
                    ///Print response code
                    if(isPrintStatus){
                        print(">> [" + requestName + "] : resulted with : " + String(responseCode))
                    }

                    if (responseCode == 200 || responseCode == 201) {
                        completion(.success(responseData))
                    }
                    //TODO: Token Handler
                    else if responseCode == 401 {
//                        AppSetting.shared.token = ""
//                        AppSetting.shared.tokenPushNotif = ""
                    }
                    else {
                        do {
                            if let responseObject = try? JSONDecoder().decode(ErrorMessage.self, from: responseData) {
                                completion(.failure(responseObject))
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}

///Define Error Message
struct ErrorMessage: Decodable {
    var message: String?
    
    init(message: String? = nil) {
        self.message = message
    }
}

///Translate result code
enum ApiResultCode {
    case invalidAppId
    case recordNotFound
    case unknown(String)
}

extension ApiResultCode {
    static func code(for string: String) -> ApiResultCode {
        switch string {
            case "invalid_app_id":
                return .invalidAppId
            case "record_not_found":
                return .recordNotFound
            default:
                return .unknown(string)
        }
    }
}

public enum Result<T, U> {
    case success(T)
    case failure(U)
}

enum NetworkRequestError: Error {
    case api(_ status: Int, _ code: ApiResultCode, _ description: String)
    case unknown(Data?, URLResponse?)
}
