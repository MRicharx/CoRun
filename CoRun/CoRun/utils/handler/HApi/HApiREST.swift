//
//  HApi.swift
//  CoRun
//
//  Created by Marselus Richard on 19/03/23.
//

import Foundation
import SwiftUI

///HApiREST - API REST Handler
///This contain func that handle request to endpoint
class HApiREST : HNetwork{
    
    
//    ///Example
//    ///Replace ResgisterResponse with data object
//    func getRequest(completion:@escaping(Result<RegisterResponse, ErrorMessage>)->Void){
//        ///Define JSON Structure
//        ///Describing refer to the parameter attribute
//        let jsonDictionary: [String: String] = [
//            "name": String(describing: name)
//        ]
//
//        request(requestName: "Example Request", endpointURL: "training/plan/id", method: "GET", parameters: jsonDictionary){ result in
//            switch result {
//            case .failure(let error):
//                ///Do Fail Thing
//                completion(.failure(error))
//            case .success(let data):
//                do {
//                    ///Do Success Thing
//                    if let responseObject = try? JSONDecoder().decode(RegisterResponse.self, from: data) {
//                        completion(.success(responseObject))
//                    }
//                }
//            }
//        }
//    }
}
