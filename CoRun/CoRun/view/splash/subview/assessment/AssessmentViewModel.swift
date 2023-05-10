//
//  AssessmentViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation

class AssessmentViewModel:SplashViewModel{
    private let model = AssessmentModel()
    
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
    
    ///Show push success
    @Published var pushSuccess = false
    ///Show failed alert
    @Published var pushFailedAlert = false
    ///Show input invalid alert
    @Published var invalidDataAlert = false
    @Published var invalidMessage = ""
    
    override init() {
        super.init()
        isLoading = false
    }
    
    ///Check data validity
    func isValid()->Bool{
        let h = Double(height) ?? 0
        let w = Double(weight) ?? 0
        
        if username == "" || height == "" || weight == ""{
            invalidMessage = "Not all forms are filled"
        }
        else if username.count<4 && username.count>12{
            invalidMessage = "Username is not valid"
        }
        else if w <= 0 && w > 900{
            invalidMessage = "Weight is not valid"
        }
        else if h <= 0 && h > 400{
            invalidMessage = "Height is not valid"
        }
        else if isLoading{
            
        }
        else{
            return true
        }
        
        if invalidMessage != ""{
            invalidDataAlert = true
        }
        return false
    }
    
    ///Push inputed personal data to endpoint
    func setPersonalData(current:ProfileData){
        isLoading = true
        
        let new = ProfileData()
        new.UserId = current.UserId
        new.Email = current.Email
        
        new.Username = username
        new.Birthday = TDate().dateToString(date: dateOfBirth, format: "YYYY/MM/dd")
        new.Height = Double(height) ?? 123
        new.Weight = Double(weight) ?? 45
        
        
        model.pushUserData(body: new){ isSuccess in
            if !(isSuccess){
                self.pushFailedAlert = true
            }else{
                self.pushSuccess = true
            }
            self.isLoading = false
        }
    }
}
