//
//  EditBiodataPopUp.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct EditBiodataPopUp: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var own : ProfileData
    ///Define parent vm
    @ObservedObject var vm:ProfileViewModel
    
    @State var newUsername = ""
    @State var newHeight = ""
    @State var newWeight = ""
    @State var newBirthday = Date.now
    
    ///Define invalid data for edit data
    @State var showInvalidAlert = false
    
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
                
                //MARK: Birthday Picker
                CDatePicker(title: "Birthday", input: $newBirthday,textColor: MColor.ColorPalette().textDefault)
                
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
                    if vm.isUserDataValid(newName: newUsername, newHeight: newHeight, newWeight: newWeight, newBD: newBirthday) && !(vm.isUploadingData){
                        vm.isUploadingData = true
                    }
                    else{
                        showInvalidAlert = true
                    }
                }label: {
                    if vm.isUploadingData{
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    else{
                        Text("Update")
                            .modifier(MFont.Headline(size:18))
                    }
                }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 14))
                
                
                //MARK: Discard Button
                Button{
                    //MARK: Discard edited biodata
                    dismiss()
                }label: {
                    Text("Discard")
                        .modifier(MFont.Headline(size: 18))
                }.buttonStyle(MButton.DefaultButton(isActive: true,invert: true,padding:14))
            }
        }
        .onChange(of: vm.isUploadingData){ isUploading in
            Task{
                vm.profileDD.username = newUsername
                vm.profileDD.height = Int(newHeight) ?? 0
                vm.profileDD.weight = Int(newWeight) ?? 0
                vm.profileDD.birthday = newBirthday
                
                await vm.updateUserData()
                vm.refreshDisplayData()
                vm.isUploadingData = false
                dismiss()
            }
        }
        .onAppear{
            ///Initialize
            newUsername = vm.profileDD.username
            newHeight = String(vm.profileDD.height)
            newWeight = String(vm.profileDD.weight)
            newBirthday = vm.profileDD.birthday
        }
        .padding(24)
        //MARK: Data Invalid Alert
        .alert(vm.invalidDataMessage,isPresented: $showInvalidAlert){
            Button("OK", role: .cancel){}
        }
    }
}

//struct EditBiodataPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        EditBiodataPopUp()
//    }
//}
