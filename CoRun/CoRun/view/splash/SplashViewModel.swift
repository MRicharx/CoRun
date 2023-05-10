//
//  SplashViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 02/04/23.
//

import Foundation
import SwiftUI

class SplashViewModel:ObservableObject{
    @Environment(\.selectedView) private var curView
    
    ///Define if query being processed
    @Published var isLoading = false
    
    private var uapi = UserAPI()
    
    ///Toogle Loading state
    func toggleLoading(){
        isLoading.toggle()
    }
    
    func getProfileData(id:String, completion:@escaping(ProfileData)->Void){
        uapi.GetUserData(userId: id){ result in
            switch result{
            case .failure(_):
                completion(ProfileData())
            case .success(let data):
                completion(data)
            }
        }
    }
    
    ///Define next view
    func defineNextView(userData:ProfileData = ProfileData())->ViewList{
        if SharedToken.shared.SignInToken == ""{
            return ViewList.splash
        }
        else if userData.Username == ""{
            return ViewList.assessment
        }
        else if SharedHealthPermission.shared.ishealthPermissionAsked != "asked"{
            return ViewList.healthPermission
        }
        else{
            return ViewList.home
        }
    }
}
