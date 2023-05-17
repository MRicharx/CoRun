//
//  ProfileViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import Foundation
import SwiftUI

class ProfileViewModel:ObservableObject{
    private var health = HHealth()
    var notif = HNotification()
    @Published var profileDD = ProfileDisplayData()
    private var bufferProfile = ProfileData()
    private var bufferCoachName = ""
    
    private let uapi = UserAPI()
    
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
    
    ///Define if currently updating data
    @Published var isUploadingData = false
    ///Define alert message for invalid data alert
    @Published var invalidDataMessage = ""
    ///Define to use placeholder on marked component
    @Published var isRedacting = true
    
    init(){
    }
    
    func refreshDisplayData(){
        profileDD.id = bufferProfile.UserId
        profileDD.username = bufferProfile.Username
        profileDD.email = bufferProfile.Email
        profileDD.height = Int(bufferProfile.Height)
        profileDD.weight = Int(bufferProfile.Weight)
        profileDD.gender = bufferProfile.Gender
        
        profileDD.coachName = bufferCoachName
        objectWillChange.send()
    }
    
    ///Load user data and get coach name
    func loadBuffer(user:ProfileData, completion:@escaping()->Void) {
        bufferProfile = user
        isRedacting = true
        
        if bufferProfile.CoachId != ""{
            uapi.GetUserData(userId: bufferProfile.CoachId){ res in
                switch res{
                case .success(let data):
                    self.bufferCoachName = data.Username
                case .failure(_):
                    print(">> Retrieve coach data failed")
                }
                self.refreshDisplayData()
                self.isRedacting = false
                completion()
            }
        }else{
            self.refreshDisplayData()
            self.isRedacting = false
            completion()
        }
    }
    
    func updateUserData() async{
        let d = bufferProfile
        d.Username = profileDD.username
        d.Weight = Double(profileDD.weight)
        d.Height = Double(profileDD.height)
        d.Birthday = TDate().dateToString(date: profileDD.birthday,format: "YYYY-MM-dd")
        
        await withCheckedContinuation{ continuation in
            uapi.UpdateUserData(body: d){ success in
                if !(success){
                    print(">> ProfileViewModel: Update User Data Failed")
                }
                else{
                    print("Updating user data")
                }
                continuation.resume()
            }
        }
    }
    
    func isUserDataValid(newName:String,newHeight:String,newWeight:String,newBD:Date)->Bool{
        let h = Double(newHeight) ?? 0
        let w = Double(newWeight) ?? 0
        
        if newName == "" || newHeight == "" || newWeight == ""{
            invalidDataMessage = "Not all forms are filled"
        }
        else if newName.count<4 && newName.count>12{
            invalidDataMessage = "Username is not valid"
        }
        else if w <= 0 && w > 900{
            invalidDataMessage = "Weight is not valid"
        }
        else if h <= 0 && h > 400{
            invalidDataMessage = "Height is not valid"
        }
        else{
            invalidDataMessage = ""
            return true
        }
        return false
    }
    func dismissCoach(){
        profileDD.coachName = ""
//        updateUserData()
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
//        SharedToken.shared.NotificationToken = ""
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
