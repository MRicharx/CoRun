//
//  SignInData.swift
//  CoRun
//
//  Created by Marselus Richard on 01/05/23.
//

import Foundation

class SignInData:Decodable{
    var uuid:String = ""
    var email:String = ""
    
    init(){}
    
    init(uuid: String, email: String) {
        self.uuid = uuid
        self.email = email
    }
}

class SignInResponse:Decodable{
    var uuid:String = ""
    var email:String = ""
    var signInToken:String = ""
    
    init(){}
    
    init(uuid: String, email: String, signInToken: String) {
        self.uuid = uuid
        self.email = email
        self.signInToken = signInToken
    }
}
