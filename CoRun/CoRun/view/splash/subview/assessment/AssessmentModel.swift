//
//  Assessment.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation

class AssessmentModel{
    private let uapi = UserAPI()
    
    func pushUserData(body:ProfileData,completion:@escaping(Bool)->Void){
        uapi.UpdateUserData(body: body){ isSuccess in
            if isSuccess{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
}
