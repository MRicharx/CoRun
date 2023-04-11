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
    @State var targetDistance = ""
    ///Define pace target in minute
    @State var targetPaceMin = ""
    ///Define pace target in second
    @State var targetPaceSec = ""
    ///Define intensity target
    @State var targetIntensity = ""
    
    var body: some View {
        VStack(spacing: 18){
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
            
            //MARK: Target Distance
            CTextfield(title: "Target Distance",hint:"--",unit: "km",type: .number, input: $targetDistance)
            
            HStack{
                //MARK: Target Pace
                CTextfield(title: "Target Distance",hint:"--",unit: "\'",type: .number, input: $targetPaceMin)
                
                //MARK: Target Distance
                CTextfield(title: "",hint:"--",unit: "\"",type: .number, input: $targetPaceSec)
            }
            
            //MARK: Target Intensity
            CTextfield(title: "Target Intensity",hint:"--",unit: "%",type: .number, input: $targetIntensity)
            
            //MARK: Button List
            VStack(spacing: 18){
                Button{
                    //TODO: Save Session Feature
                }label: {
                    Text("Save Session")
                        .modifier(MFont.Headline(size:18))
                }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 12))
                
                Button{
                    //TODO: Discard Session Feature
                }label: {
                    Text("Discard")
                        .modifier(MFont.Headline(size:18))
                }.buttonStyle(MButton.DangerButton(isActive: true,invert: true,padding: 12))
                
            }
        }
        .padding(24)
        .modifier(MView.FillFrame())
    }
}

struct CDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        CDashboardView()
    }
}
