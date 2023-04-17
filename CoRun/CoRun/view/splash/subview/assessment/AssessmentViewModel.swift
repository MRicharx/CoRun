//
//  AssessmentViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation

class AssessmentViewModel:SplashViewModel{
    ///Username input
    @Published var username:String = ""
    ///Gender Choice
    @Published var gender:String = "Male"
    ///User birthday
    @Published var dateOfBirth = Date.now
    ///Height input
    @Published var height:String = ""
    ///Weight input
    @Published var weight:String = ""
    
    override init() {
        
    }
    
    ///Save and store inputed personal data to account
    func setPersonalData(){
        //TODO: Set Inputed Data Here
        //TODO: Check data validity before post
        toggleLoading()
    }
}
