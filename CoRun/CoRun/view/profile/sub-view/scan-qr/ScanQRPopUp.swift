//
//  ScanQRPopUp.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct ScanQRPopUp: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var own : ProfileData
    
    ///Define Coach ID from TextField input
    @State var id = ""
    ///Define Coach ID from Scanner Input
    @State var scanResult = ""
    
    @StateObject var vm = ScanQRViewModel()
    
    var body: some View {
        ZStack{
            //MARK: Camera View
            QRScanner(result: $scanResult)
            
            VStack{
                VStack{
                    Text("Scan Coach QR")
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                }
                .padding(18)
                .modifier(MView.Card())
                
                Spacer()
                
                VStack(spacing:12){
                    //MARK: Divider
                    HStack(spacing: 18){
                        CDivider(color: MColor.ColorPalette().textDisabled)
                        
                        Text("Or")
                            .modifier(MFont.Headline(size:16))
                            .modifier(MColor.DisabledText())
                        
                        CDivider(color: MColor.ColorPalette().textDisabled)
                    }.modifier(MView.safePadding())
                    
                    CTextfield(title: "Input Coach ID Here",hint:"Coach ID", input: $id)
                    
                    VStack(spacing: 12){
                        //MARK: Search Button
                        Button{
                            //TODO: Search coach
                            scanResult = id
                        }label:{
                            Text("Search Coach")
                                .modifier(MFont.Headline(size:18))
                        }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 12))
                        
                        //MARK: Cancel Button
                        Button{
                            dismiss()
                        }label:{
                            Text("Cancel")
                                .modifier(MFont.Headline(size:18))
                        }.buttonStyle(MButton.DefaultButton(isActive: true,invert:true, padding: 12))
                    }
                }
                .padding(24)
                .modifier(MView.Card())
            }
            .padding(0)
            //MARK: Scan Result Alert
            .onChange(of: scanResult){ res in
                Task{
                    await vm.retrieveCoach(id:res)
                    vm.showRequestAlert = true
                }
            }
            //MARK: Send Request Alert
            .alert("Are you sure want to send request to\nCoach \(vm.coachName)?", isPresented: $vm.showRequestAlert){
                    Button("Send"){
                        //TODO: Send Request Feature
                        Task{
                            await vm.sendRequest(ownId: own.UserId, coachId: scanResult)
                        }
                    }
                    Button("Cancel",role: .cancel){
                        scanResult = ""
                    }
                }
            .alert("Request to Coach \(vm.coachName) Sent", isPresented: $vm.showSuccessAlert){
                    Button("OK",role: .cancel){
                        dismiss()
                    }
                }
        }
    }
}

struct ScanQRPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ScanQRPopUp()
    }
}
