//
//  CProfileCoach.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct CProfileCoach: View {
    ///Define coach name
    @State var coach:String
    
    var body: some View {
        VStack(spacing: 18){
            //MARK: Title
            HStack(spacing : 18){
                Group{
                    Image(systemName: "person.wave.2.fill")
                        .modifier(MColor.Primary())
                    Text("Your Coach")
                        .modifier(MColor.Text())
                }.modifier(MFont.Headline())
            }
            .modifier(MView.FillToLeftFrame())
            
            //MARK: Content
            VStack(alignment:.leading,spacing: 6){
                if(coach==""){
                    Text("Currently you have no Coach")
                        .modifier(MFont.Body(size:18))
                        .modifier(MColor.DisabledText())
                    
                    //MARK: Assign Coach Button
                    Button{
                        //TODO: Show Assign Coach View
                    }label:{
                        Text("Assign Coach")
                            .modifier(MFont.Headline(size:18))
                    }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 8))
                }else{
                    Text("Current Coach")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                    Text("Coach " + coach)
                        .modifier(MFont.Headline())
                        .foregroundColor(MColor.ColorPalette().textDefault)
                }
            }.modifier(MView.FillToLeftFrame())
            
        }.padding(18)
            .modifier(MView.Card())
    }
}

struct CProfileCoach_Previews: PreviewProvider {
    static var previews: some View {
        CProfileCoach(coach: "Budiman")
    }
}
