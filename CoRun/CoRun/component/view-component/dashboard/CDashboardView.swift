//
//  CDashboardView.swift
//  CoRun
//
//  Created by Marselus Richard on 30/03/23.
//

import SwiftUI

///CDashboardView
///Custom view for create and edit training session
struct CDashboardView: View {
    ///Define distance target
    @State var title = "Berlari"
    ///Define distance target
    @State var targetDistance = ""
    ///Define pace target in minute
    @State var targetPaceMin = ""
    ///Define pace target in second
    @State var targetPaceSec = ""
    ///Define intensity target
    @State var targetIntensity = ""
    
    var body: some View {
        VStack(spacing:12){
            VStack(spacing:24){
                //MARK: Date
                VStack(alignment:.leading){
                    Text("Date")
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.DisabledText())
                    Text("20 March 2023")
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                }
                .modifier(MView.FillToLeftFrame())
                
                CTextfield(title: "Activity Title", input: $title)
                
                HStack(spacing:24){
                    CDivider()
                    Text("Optional")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                    CDivider()
                }
                
                //MARK: Goal
                VStack{
                    //MARK: Target Distance
                    CTextfield(title: "Target Distance",hint:"--",unit: "km",type: .number, input: $targetDistance)
                    
                    //MARK: Pace
                    HStack(spacing:18){
                        //MARK: Target Pace
                        CTextfield(title: "Target Pace",hint:"--",unit: "\'",type: .number, input: $targetPaceMin)
                        
                        //MARK: Target Distance
                        CTextfield(title: "",hint:"--",unit: "\"",type: .number, input: $targetPaceSec)
                    }
                    
                    //MARK: Duration
                    HStack(spacing:18){
                        //MARK: Hour
                        CTextfield(title: "Duration",hint:"--",unit: "hour",type: .number, input: $targetPaceMin)
                        
                        //MARK: minute
                        CTextfield(title: "",hint:"--",unit: "min",type: .number, input: $targetPaceSec)
                    }
                    
                    //MARK: Target Intensity
                    CTextfield(title: "Target Intensity",hint:"--",unit: "%",type: .number, input: $targetIntensity)
                    
                    //MARK: Desc
                    CTextfield(title: "Description",hint:"",unit: "",type: .number, input: $targetIntensity)
                }
                
            }
            .padding(24)
            .modifier(MView.Card())
            
            //MARK: Button List
            VStack(spacing: 0){
                Button{
                    //TODO: Save Session Feature
                }label: {
                    Text("Save Session")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.Primary())
                        .modifier(MView.FillToLeftFrame())
                }.buttonStyle(MButton.ListButton())
                
                Button{
                    //TODO: Discard Session Feature
                }label: {
                    Text("Discard")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.Danger())
                        .modifier(MView.FillToLeftFrame())

                }.buttonStyle(MButton.ListButton())
                
            }
            
            Spacer()
        }
    }
}

struct CDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        CDashboardView()
    }
}
