//
//  EditBiodataPopUp.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct EditBiodataPopUp: View {
    @Environment(\.dismiss) var dismiss
    ///Define parent vm
    @ObservedObject var vm:ProfileViewModel
    
    @State var newUsername = ""
    @State var newHeight = ""
    @State var newWeight = ""
    
    
    ///Define save alert display behavior
    @State var showSaveAlert = false
    ///Define discard alert display behavior
    @State var showDiscardAlert = false
    
    var body: some View {
        VStack(spacing:36){
            //MARK: Content Data
            VStack(spacing: 12){
                //MARK: Email
                VStack(alignment:.leading,spacing:4){
                    Text("Email")
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.DisabledText())
                    Text(vm.profileDD.email)
                        .modifier(MFont.Headline())
                        .tint(MColor.ColorPalette().textDefault)
//                        .modifier(MColor.Text())
                }
                .modifier(MView.FillToLeftFrame())
                
                //MARK: Gender
                VStack(alignment:.leading,spacing:4){
                    Text("Gender")
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.DisabledText())
                    Text(vm.profileDD.gender)
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                }.modifier(MView.FillToLeftFrame())
                
                //MARK: Username TF
                CTextfield(title: "Username",input: $newUsername)
                
                //MARK: Height TF
                CTextfield(title: "Height",unit: "cm", input: $newHeight)
                
                //MARK: Weight TF
                CTextfield(title: "Weight",unit: "kg", input: $newWeight)
            }
            
            Spacer()
            
            //MARK: Button
            VStack(spacing:12){
                //MARK: Update Button
                Button{
                    //TODO: Update biodata
                    showSaveAlert = true
                }label: {
                    Text("Update")
                        .modifier(MFont.Headline(size:18))
                }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 14))
                
                
                //MARK: Discard Button
                Button{
                    //TODO: Discard edited biodata
                    showDiscardAlert = true
                }label: {
                    Text("Discard")
                        .modifier(MFont.Headline(size: 18))
                }.buttonStyle(MButton.DefaultButton(isActive: true,invert: true,padding:14))
            }
        }
        .onAppear{
            ///Initialize
            newUsername = vm.profileDD.username
            newHeight = String(vm.profileDD.height)
            newWeight = String(vm.profileDD.weight)
        }
        .padding(24)
        //MARK: Save Alert
        .alert(
            "Do you want to update you data?",
            isPresented: $showSaveAlert){
                //MARK: Proceed
                Button{
                    //TODO: Update biodata at endpoint and local
                    vm.profileDD.username = newUsername
                    vm.profileDD.height = Int(newHeight) ?? 99
                    vm.profileDD.weight = Int(newWeight) ?? 99
                    
                    vm.updateUserData()
                    dismiss()
                }label:{
                    Text("Update")
                    
                }
                //MARK: Cancel
                Button(role:.cancel){
                    ///DO NOTHING
                }label:{
                    Text("Cancel")
                        .modifier(MFont.Headline())
                }
            }
        //MARK: Discard Alert
            .alert(
                "Do you want to discard the edit?",
                isPresented: $showDiscardAlert){
                    Button(role:.destructive){
                        dismiss()
                    }label:{
                        Text("Discard")
                    }
                }
    }
}

//struct EditBiodataPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        EditBiodataPopUp()
//    }
//}
