//
//  AssessmentView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct AssessmentView: View {
    @Environment(\.selectedView) var curView
    @EnvironmentObject private var own:ProfileData
    
    ///Define current view model
    @StateObject var vm = AssessmentViewModel()
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            VStack(alignment:.leading, spacing: 36){
                //MARK: Title
                Text("Input Your\nBiodata")
                    .modifier(MColor.Text())
                    .modifier(MFont.Title2())
                
                VStack(spacing: 24){
                    //MARK: Username TF
                    CTextfield(title: "Username", desc: "Need to contain 4-12 characters", hint: "Username",maxChar: 12, input: $vm.username)
                    
                    //MARK: Gender Checkbox
                    CCheckBox(title: "Gender",option: ["Male","Female"] , selected: $vm.gender)
                    
                    //MARK: Birthday Picker
                    CDatePicker(title: "Birthday", input: $vm.dateOfBirth)
                    
                    //MARK: Height TF
                    CTextfield(title: "Height", hint: "160", unit: "cm",maxChar: 3, type: .number,input: $vm.height)
                    //MARK: Weight TF
                    CTextfield(title: "Weight", hint: "65", unit: "kg",maxChar: 3, type:.number,input: $vm.weight)
                }
                
                Spacer()
                
                //MARK: Confirm Button
                Button{
                    if vm.isValid(){
                        vm.setPersonalData(current:own)
                    }
                }label:{
                    if vm.isLoading{
                        ProgressView()
                            .progressViewStyle(.circular)
                    }else{
                        Text("Confirm")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Base())
                    }
                }.buttonStyle(MButton.DefaultButton(isActive: true))
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
            .modifier(MView.FillFrame())
        }
        .alert(vm.invalidMessage, isPresented: $vm.invalidDataAlert){
            Button("OK",role: .cancel) {}
        }
        .onChange(of: vm.pushSuccess){ _ in
            withAnimation{
                vm.getProfileData(id:own.UserId){ res in
                    own.set(new: res)
                    curView.wrappedValue = vm.defineNextView(userData: own)
                }
            }
        }
        
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssessmentView()
    }
}
