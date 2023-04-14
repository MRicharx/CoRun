//
//  ScanQRPopUp.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct ScanQRPopUp: View {
    @Environment(\.dismiss) var dismiss
    
    ///Define Coach ID from TextField input
    @State var id = ""
    ///Define Coach ID from Scanner Input
    @State var scanResult = ""
    
    ///Define Target Coach
    @State var coachName = "Budiman"
    
    ///Define Request Alert Behavior
    @State var showRequestAlert = false
    
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
            .onChange(of: scanResult,perform: { _ in
                //TODO: Check if coach Exist
                if(!(coachName.isEmpty)){
                    coachName = scanResult
                    showRequestAlert = true
                }
            })
            //MARK: Send Request Alert
                .alert("Send request to\nCoach \(coachName)", isPresented: $showRequestAlert){
                    Button("Send"){
                        //TODO: Send Request Feature
                    }
                    Button("Cancel",role: .cancel){
                        scanResult = ""
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
