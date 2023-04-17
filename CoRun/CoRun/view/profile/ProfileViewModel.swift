//
//  ProfileViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import Foundation
import SwiftUI

class ProfileViewModel:ObservableObject{
    @Published var profileDD = ProfileDisplayData()
    
    init(){
        let local = SharedUser.shared.UserData
        if(local.id != ""){
            profileDD.id = local.id
            profileDD.username = local.username
            profileDD.email = local.email
            profileDD.height = local.height
            profileDD.weight = local.weight
            profileDD.gender = local.gender

            profileDD.coachName = local.coachName
        }else{
            loadDummy()
        }
    }
    
    func updateUserData(){
        var local = SharedUser.shared.UserData
        local.id = profileDD.id
        local.email = profileDD.email
        local.gender = profileDD.gender
        local.refreshToken = "Empty Token"
        local.username = profileDD.username
        local.weight = profileDD.weight
        local.height = profileDD.height
        local.coachName = profileDD.coachName
        
        SharedUser.shared.UserData = local
    }
    func dismissCoach(){
        profileDD.coachName = ""
        updateUserData()
    }
    func toggleHealthPermission(){
        profileDD.isHealthAllowed.toggle()
        //TODO: Toggle Health Permission
    }
    func deleteToken(){
        SharedToken.shared.SignInToken = ""
        SharedToken.shared.NotificationToken = ""
    }
    private func getHealthPermissionStatus()->Bool{
        //MARK: Check current health permission status
        return true
    }
    
    private func loadDummy(){
        print(">> ProfileViewModel: LoadDummy()")
        profileDD.id = "Sembarang"
        profileDD.username = "Budiman"
        profileDD.email = "email@mail.com"
        profileDD.height = 170
        profileDD.weight = 70
        profileDD.gender = "Male"
        
        profileDD.coachName = "Bambang"
        profileDD.isHealthAllowed = getHealthPermissionStatus()
    }
}
