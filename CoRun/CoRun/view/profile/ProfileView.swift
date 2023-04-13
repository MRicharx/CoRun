//
//  PrifileVIew.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    
    ///State Edit Biodata Pop Up Status
    @State var showEditData = false
    ///State User Coach QR Pop Up Status
    @State var showQRPopUp = false
    ///State Assign Coach Pop Up Status
    @State var showScanQR = false
    ///Define Sign Out Alert Behavior
    @State var showSignOUtAlert = false
    
    ///Define current assigned coach
    @State var currentCoach = ""
    ///Define current reminder status
    @State var isReminderActive = true
    ///Define current health status
    @State var isHealthAllowed = true
    ///Define reminder value
    @State var reminderValue = Date.now
    
    var body: some View {
        VStack(spacing:12){
            //MARK: Biodata Section
            VStack{
                //MARK: Data
                VStack(alignment:.leading,spacing:8){
                    Text("Username")
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                    Text("Mail@mail.com")
                        .tint(MColor.ColorPalette().textDisabled)
                        .modifier(MFont.SubBody())
                }.modifier(MView.FillToLeftFrame())
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 12, trailing: 24))
                
                //MARK: Button List
                VStack(spacing:0){
                    //MARK: Edit
                    Button{
                        //TODO: Navigate to Feedback
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
                        //TODO: Navigate to Feedback
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
                        //TODO: Navigate to Feedback
                    }label:{
                        HStack(spacing:12){
                            Image(systemName: "person.circle.fill")
                                .modifier(MColor.Primary())
                                .modifier(MFont.Body())
                            Group{
                                Text("My Coach")
                                    .modifier(MColor.Text())
                                    .modifier(MView.FillToLeftFrame())
                                Image(systemName: "chevron.right")
                                    .modifier(MColor.DisabledText())
                            }
                            .modifier(MFont.SubBody())
                        }
                    }.buttonStyle(MButton.ListButton())
                    
                    //MARK: Daily Reminder
                    Button{
                        //TODO: Navigate to Feedback
                        isReminderActive.toggle()
                    }label:{
                        HStack(alignment:.top, spacing:12){
                            Image(systemName: "alarm.fill")
                                .modifier(MColor.Primary())
                                .modifier(MFont.Body())
                            Group{
                                VStack(alignment:.leading,spacing: 8){
                                    Text("Daily Reminder")
                                        .modifier(MColor.Text())
                                        .modifier(MView.FillToLeftFrame())
                                    CPicker(isReminderActive: $isReminderActive, currentReminder: $reminderValue)
                                }
                                Toggle("",isOn: $isReminderActive)
                            }
                            .modifier(MFont.SubBody())
                        }
                    }.buttonStyle(MButton.ListButton())
                    
                    //MARK: Apple Health
                    Button{
                        //TODO: Navigate to Feedback
                        isHealthAllowed.toggle()
                    }label:{
                        HStack(spacing:12){
                            Image("health")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 28)
                            Group{
                                Text("Apple Health")
                                    .modifier(MColor.Text())
                                    .modifier(MView.FillToLeftFrame())
                                Toggle("",isOn: $isHealthAllowed)
                            }
                            .modifier(MFont.SubBody())
                        }
                    }.buttonStyle(MButton.ListButton())
                }
            }.modifier(MView.Card())
            
            //MARK: My Trainee
            VStack{
                //MARK: Daily Reminder
                Button{
                    //TODO: Navigate to Feedback
                }label:{
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
                }.buttonStyle(MButton.ListButton())
            }
            .modifier(MView.Card())
            
            Spacer()
            
            //MARK: Sign Out
            Button{
                showSignOUtAlert = true
            }label:{
                VStack{
                    Text("Sign Out")
                        .modifier(MFont.Headline(size: 18))
                        .modifier(MColor.Danger())
                }.modifier(MView.FillFrame())
            }
        }
        
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment:.leading,spacing: 24){
                    //MARK: Title
                    Text("My Profile")
                        .modifier(MView.safePadding())
                        .modifier(MColor.Text())
                        .modifier(MFont.Title())
                    
                    //MARK: Biodata
                    CProfileBiodata(
                        showQR: $showQRPopUp,
                        showEdit: $showEditData
                    )
                    
                    //MARK: Coach
                    CProfileCoach(showScanQR: $showScanQR, coach: currentCoach)
                    
                    //MARK: Reminder
                    CProfileReminder(
                        isReminderActive: $isReminderActive,
                        currentReminder: $reminderValue)
                    
                    //MARK: Trainee List
                    VStack{
                        HStack{
                            Group{
                                Image(systemName: "person.crop.rectangle.stack.fill")
                                    .modifier(MColor.Primary())
                                Text("My Trainee List")
                                    .modifier(MColor.Text())
                            }.modifier(MFont.Headline())
                        }.modifier(MView.FillToLeftFrame())
                    }.padding(18)
                    .modifier(MView.Card())
                    
                    //MARK: Sign Out
                    Button{
                        showSignOUtAlert = true
                    }label:{
                        VStack{
                            Text("Sign Out")
                                .modifier(MFont.Headline(size: 18))
                                .modifier(MColor.Danger())
                        }.modifier(MView.FillFrame())
                    }
                }
            }
        }
        //MARK: Edit Controller
        .sheet(isPresented: $showEditData){
            //TODO: Create proper edit data passement
            EditBiodataPopUp()
        }
        //MARK: QR Controller
        .sheet(isPresented: $showQRPopUp){
            //TODO: Create proper id passement
            QRPopUp(id: "Youtube.com")
        }
        //MARK: ScanQR Controller
        .fullScreenCover(isPresented: $showScanQR){
            //TODO: Create proper model
            ScanQRPopUp()
        }
        //MARK: SignOut Alert
        .alert(
            "Are you sure want to SIGN OUT",
            isPresented: $showSignOUtAlert){
                Button("SIGN OUT", role:.destructive){
                    //TODO: Create SIGN OUT feature
                }
            }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
