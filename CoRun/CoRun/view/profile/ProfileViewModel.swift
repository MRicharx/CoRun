//
//  ProfileViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import Foundation
import SwiftUI

class ProfileViewModel:ObservableObject{
    var health = HHealth()
    @Published var profileDD = ProfileDisplayData()
    
    ///State Edit Biodata Pop Up Status
    @Published var showEditData = false
    ///State User Coach QR Pop Up Status
    @Published var showQRPopUp = false
    ///State Scan QR View  Status
    @Published var showScanQR = false
    ///Define Sign Out Alert Behavior
    @Published var showSignOUtAlert = false
    ///State Coach status alert
    @Published var showCoachAlert = false
    ///State Notification Permission is denied alert
    @Published var showPermissionAlert = false
    ///State Health Permission is requested
    @Published var showHealthAlert = false
    ///Define Health Alert message
    @Published var healthAlertMessage = ""
    @Published var isHealthPermissionLoading = false
    
    init(){
        let local = SharedUser.shared.UserData
        if(local.id != ""){
            profileDD.id = local.id
            profileDD.username = local.username
            profileDD.email = local.email
            profileDD.height = local.height
            profileDD.weight = local.weight
            profileDD.gender = local.gender
            profileDD.birthday = TDate().stringToDate(date: local.dateOfBirth)

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
        local.dateOfBirth = TDate().dateToString(date: profileDD.birthday)
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
    func requestHealthPermission(completion: @escaping ((_ status: Bool) -> Void)){
        //TODO: Toggle Health Permission
        isHealthPermissionLoading = true
        health.requestPermission{ result in
            if result{
                self.healthAlertMessage = "Permission have been requested"
            }
            else{
                self.healthAlertMessage = "Error have occured"
            }
            self.isHealthPermissionLoading = false
            completion(true)
        }
    }
    func deleteToken(){
        SharedToken.shared.SignInToken = ""
        SharedToken.shared.NotificationToken = ""
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
    }
}
