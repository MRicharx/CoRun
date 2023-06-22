//
//  PrifileVIew.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.selectedView) var curView
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var own : ProfileData
    
    @StateObject var vm = ProfileViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing:12){
                //MARK: Biodata Section
                VStack{
                    //MARK: Data
                    VStack(alignment:.leading,spacing:8){
                        Text(vm.profileDD.username)
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                            .redacted(reason: vm.isRedacting ? .placeholder : [])
                        Text(vm.profileDD.email)
                            .tint(MColor.ColorPalette().textDisabled)
                            .modifier(MFont.SubBody())
                            .redacted(reason: vm.isRedacting ? .placeholder : [])
                    }.modifier(MView.FillToLeftFrame())
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 12, trailing: 24))
                    
                    //MARK: Button List
                    VStack(spacing:0){
                        //MARK: Edit
                        Button{
                            //TODO: Navigate to Edit
                            vm.showEditData=true
                        }label:{
                            HStack(spacing:12){
                                Image(systemName: "square.and.pencil.circle.fill")
                                    .modifier(MColor.Primary())
                                    .modifier(MFont.Body())
                                Group{
                                    Text("Edit Biodata")
                                        .modifier(MColor.Text())
                                        .modifier(MView.FillToLeftFrame())
                                    Image(systemName: "chevron.right")
                                        .modifier(MColor.DisabledText())
                                }
                                .modifier(MFont.SubBody())
                            }
                        }.buttonStyle(MButton.ListButton())
                        
                        //MARK: Show QR
                        Button{
                            //TODO: Navigate to QR
                            vm.showQRPopUp=true
                        }label:{
                            HStack(spacing:12){
                                Image(systemName: "qrcode")
                                    .modifier(MColor.Primary())
                                    .modifier(MFont.Body())
                                Group{
                                    Text("Show QR")
                                        .modifier(MColor.Text())
                                        .modifier(MView.FillToLeftFrame())
                                    Image(systemName: "chevron.right")
                                        .modifier(MColor.DisabledText())
                                }
                                .modifier(MFont.SubBody())
                            }
                        }.buttonStyle(MButton.ListButton())
                    }
                }.modifier(MView.Card())
                
                //MARK: Setting Section
                VStack{
                    //MARK: Title
                    Text("Setting")
                        .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
                        .modifier(MFont.Headline(size:14))
                        .modifier(MColor.DisabledText())
                        .modifier(MView.FillToLeftFrame())
                    
                    //MARK: Button List
                    VStack(spacing:0){
                        //MARK: My Coach
                        Button{
                            //TODO: Navigate to My Coach
                            if vm.profileDD.coachName == ""{
                                vm.showScanQR=true
                            }else{
//                                vm.showCoachAlert=true
                            }
                        }label:{
                            HStack(alignment:.top, spacing:12){
                                Image(systemName: "person.circle.fill")
                                    .modifier(MColor.Primary())
                                    .modifier(MFont.Body())
                                Group{
                                    VStack(alignment:.leading,spacing: 8){
                                        Text("My Coach")
                                            .modifier(MColor.Text())
                                            .modifier(MView.FillToLeftFrame())
                                        if vm.profileDD.coachName == ""{
                                            Text("Assign coach here")
                                                .modifier(MFont.Body())
                                                .modifier(MColor.DisabledText())
                                                .modifier(MView.FillToLeftFrame())
                                                .redacted(reason: vm.isRedacting ? .placeholder : [])
                                        }else{
                                            Text(vm.profileDD.coachName)
                                                .modifier(MFont.Headline())
                                                .modifier(MColor.Text())
                                                .modifier(MView.FillToLeftFrame())
                                                .redacted(reason: vm.isRedacting ? .placeholder : [])
                                        }
                                        
                                    }
                                }
                                .modifier(MFont.SubBody())
                            }
                        }.buttonStyle(MButton.ListButton())
                        
                        //MARK: Daily Reminder
                        CPickerView()
                        
                        //MARK: Difficulty
                        Button{
                            //TODO: Toggle health permission
                            vm.showDifficultySetting = true
                        }label:{
                            HStack(spacing:12){
                                Image(systemName: "scalemass.fill")
                                    .modifier(MColor.Primary())
                                Group{
                                    Text("Difficulty")
                                        .modifier(MColor.Text())
                                        .modifier(MView.FillToLeftFrame())
                                }
                                .modifier(MFont.SubBody())
                            }
                        }.buttonStyle(MButton.ListButton())
                    }
                }.modifier(MView.Card())
                
                //MARK: My Trainee
                NavigationLink{
                    TraineeListView()
                }label:{
                    VStack{
                        HStack(spacing:12){
                            Image(systemName: "person.crop.rectangle.stack.fill")
                                .modifier(MColor.Primary())
                                .modifier(MFont.Body())
                            Group{
                                Text("My Trainee")
                                    .modifier(MColor.Text())
                                    .modifier(MView.FillToLeftFrame())
                                Image(systemName: "chevron.right")
                                    .modifier(MColor.DisabledText())
                            }
                            .modifier(MFont.SubBody())
                        }
                        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
                    }
                    .modifier(MView.Card())
                }
                
                Spacer()
                
                //MARK: Sign Out
                Button{
//                    vm.notif.pushDummyNotification()
                    vm.showSignOUtAlert = true
                }label:{
                    VStack{
                        Text("Sign Out")
                            .modifier(MFont.Headline(size: 18))
                            .modifier(MColor.Danger())
                    }.modifier(MView.FillFrame())
                }
            }
        }
        .onAppear{
            Task{
                vm.loadBuffer(user:own){
                    vm.refreshDisplayData()
                }
            }
        }
        .environment(\.notificationPermissionAlert, $vm.showPermissionAlert)
        //MARK: Set Difficulty
        .sheet(isPresented: $vm.showDifficultySetting){
            DifficultyView()
        }
        //MARK: Edit Controller
        .sheet(isPresented: $vm.showEditData){
            EditBiodataPopUp(vm:vm)
        }
        //MARK: QR Controller
        .sheet(isPresented: $vm.showQRPopUp){
            //TODO: Create proper id passement
            QRPopUp(id: vm.profileDD.id)
        }
        //MARK: ScanQR Controller
        .fullScreenCover(isPresented: $vm.showScanQR){
            //TODO: Create proper model
            ScanQRPopUp()
        }
        //MARK: Permission alert
        .alert(
            "Please enable notification permission on your device setting",isPresented: $vm.showPermissionAlert){
                Button("OK",role: .cancel){
                    /// DO NOTHING
                }
            }
        //MARK: SignOut Alert
        .alert(
            "Are you sure want to SIGN OUT",
            isPresented: $vm.showSignOUtAlert){
                Button("SIGN OUT", role:.destructive){
                    //TODO: Create SIGN OUT feature
                    vm.deleteToken()
                    curView.wrappedValue = ViewList.splash
                }
                Button("DELETE ACCOUNT", role:.destructive){
                    //MARK: Delete Account Feature
                    vm.deleteAccount(userId: own.UserId){
                        vm.deleteToken()
                    }
                    curView.wrappedValue = ViewList.splash
                }
            }
        //MARK: Coach Alert
        .alert(
            "Currently your coach is:\n\(vm.profileDD.coachName)",isPresented: $vm.showCoachAlert){
                Button("DISMISS COACH",role: .destructive){
                    //TODO: Dismiss coach feature
                    vm.dismissCoach()
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
