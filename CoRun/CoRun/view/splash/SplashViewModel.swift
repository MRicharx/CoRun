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
    
    ///Toogle Loading state
    func toggleLoading(){
        isLoading.toggle()
    }
    
    ///Check if user already signed in
    func isSignedIn()->Bool{
//        if SharedToken.shared.SignInToken == ""{
//            return false
//        }else{
//            return true
//        }
        
        //MARK: for testing purpose
        return true
    }
    
    ///Sign In to retrieve user account data and or Create account at endpoint
    func signIn(){
        //TODO: Sign Feature
        isLoading = true
    }
    
    ///Check if user already filled first assessment
    private func isAssessmentDone()->Bool{
        //TODO: Check Assessment condition
        return true
    }
    ///Check if health have access permission
    private func isHealthAllowed()->Bool{
        //TODO: Check Health Permission
        return true
    }
    
    ///Define next case need to be completed
    func defineNextView()->ViewList{
        if !(isAssessmentDone()){
            return .assessment
        }
        else if !(isHealthAllowed()){
            return .healthPermission
        }
        else{
            return .home
        }
    }
}
