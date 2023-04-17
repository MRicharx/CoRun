//
//  AssessmentView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct AssessmentView: View {
    @Environment(\.selectedView) var curView
    
    ///Define current view model
    @StateObject var vm = AssessmentViewModel()
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            VStack(alignment:.leading, spacing: 36){
                //MARK: Title
                Text("My Personal\nInformation")
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
                    CTextfield(title: "Height", hint: "160", unit: "cm", type: .number,input: $vm.height)
                    //MARK: Weight TF
                    CTextfield(title: "Weight", hint: "65", unit: "kg", type:.number,input: $vm.weight)
                }
                
                Spacer()
                
                //MARK: Confirm Button
                if(vm.username == "" || vm.height == "" || vm.weight == "" ){
                    Button{
                        ///Do NOTHING
                    }label:{
                        Text("Confirm")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Base())
                    }.buttonStyle(MButton.DefaultButton(isActive: false))
                }else{
                    Button{
                        if !(vm.isLoading){
                            //TODO: Set Function here
                            vm.setPersonalData()
                            
                            curView.wrappedValue = vm.defineNextView()
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
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
            .modifier(MView.FillFrame())
        }
        .onAppear {
            curView.wrappedValue = vm.defineNextView()
        }
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssessmentView()
    }
}
