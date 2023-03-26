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
    
    ///Define current assigned coach
    @State var currentCoach = ""
    
    var body: some View {
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
                CProfileReminder()
                
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
                    //TODO: Sign Out Button
                }label:{
                    VStack{
                        Text("Sign Out")
                            .modifier(MFont.Headline(size: 18))
                            .modifier(MColor.Danger())
                    }.modifier(MView.FillFrame())
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
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
