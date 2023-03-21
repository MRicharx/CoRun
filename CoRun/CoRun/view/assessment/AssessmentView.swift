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
            Color("base")
                .ignoresSafeArea()
            
            VStack(alignment:.leading, spacing: 36){
                Text("My Personal\nInformation")
                    .modifier(MColor.Text())
                    .modifier(MFont.Title())
                
                VStack(spacing: 10){
                    //MARK: Username TF
                    Textfield(title: "Username", desc: "Need to contain 4-12 characters", hint: "Username", input: $username)
                    
                    //MARK: Gender Checkbox
                    CheckBox(title: "Gender",option: ["Male","Female"] , input: $gender)
                    
                    //MARK: Height TF
                    Textfield(title: "Height", hint: "160", unit: "CM", input: $height)
                    //MARK: Weight TF
                    Textfield(title: "Weight", hint: "65", unit: "KG", input: $weight)
                }
                
                Spacer()
                
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
