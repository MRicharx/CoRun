//
//  AssessmentView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct AssessmentView: View {
    ///Username input
    @State var username:String = ""
    ///Gender Choice
    @State var gender:String = "Male"
    ///Height input
    @State var height:String = ""
    ///Weight input
    @State var weight:String = ""
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            VStack(alignment:.leading, spacing: 36){
                //MARK: Title
                Text("My Personal\nInformation")
                    .modifier(MColor.Text())
                    .modifier(MFont.Title())
                
                VStack(spacing: 24){
                    //MARK: Username TF
                    CTextfield(title: "Username", desc: "Need to contain 4-12 characters", hint: "Username",maxChar: 12, input: $username)
                    
                    //MARK: Gender Checkbox
                    CCheckBox(title: "Gender",option: ["Male","Female"] , selected: $gender)
                    
                    //MARK: Height TF
                    CTextfield(title: "Height", hint: "160", unit: "cm", type: .number,input: $height)
                    //MARK: Weight TF
                    CTextfield(title: "Weight", hint: "65", unit: "kg", type:.number,input: $weight)
                }
                
                Spacer()
                
                //MARK: Confirm Button
                if(username == "" || height == "" || weight == ""){
                    Button{
                        //TODO: Set Function here
                    }label:{
                        Text("Confirm")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Base())
                    }.buttonStyle(MButton.DefaultButton(isActive: false))
                }else{
                    Button{
                        //TODO: Set Function here
                    }label:{
                        Text("Confirm")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Base())
                    }.buttonStyle(MButton.DefaultButton(isActive: true))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
            .modifier(MView.FillFrame())
        }
    }
}

struct AssessmentView_Previews: PreviewProvider {
    static var previews: some View {
        AssessmentView()
    }
}
