//
//  CProfileBiodata.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct CProfileBiodata: View {
    var body: some View {
        VStack(spacing: 16){
            //MARK: Username
            VStack(alignment:.leading,spacing: 4){
                Text("Username")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.DisabledText())
                Text("Budiman")
                    .modifier(MFont.Body())
                    .modifier(MColor.Text())
                
            }.modifier(MView.FillToLeftFrame())
            
            //MARK: Email
            VStack(alignment:.leading,spacing: 4){
                Text("Email")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.DisabledText())
                Text("email@mail.com")
                    .modifier(MFont.Body())
                    .foregroundColor(MColor.ColorPalette().textDefault)
            }.modifier(MView.FillToLeftFrame())
            
            //MARK: Data
            HStack{
                //MARK: Gender
                VStack(alignment:.leading,spacing: 4){
                    Text("Gender")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                    Text("Male")
                        .modifier(MFont.Body())
                        .modifier(MColor.Text())
                    
                }.modifier(MView.FillToLeftFrame())
                
                //MARK: Height
                VStack(alignment:.leading,spacing: 4){
                    Text("Height")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                    Text("160 cm")
                        .modifier(MFont.Body())
                        .modifier(MColor.Text())
                    
                }.modifier(MView.FillToLeftFrame())
                
                //MARK: Weight
                VStack(alignment:.leading,spacing: 4){
                    Text("Weight")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                    Text("65 kg")
                        .modifier(MFont.Body())
                        .modifier(MColor.Text())
                    
                }.modifier(MView.FillToLeftFrame())
            }
            
            //MARK: Edit Button
            Button{
                //TODO: Show Edit View
            }label:{
                Text("Edit")
                    .modifier(MFont.Headline(size:18))
            }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 8))
            
            //MARK: ShowQR Button
            Button{
                //TODO: ShowQR View
            }label:{
                HStack{
                    Group{
                        Text("Show QR")
                        Image(systemName: "qrcode")
                    }.modifier(MFont.Headline(size:18))
                }
            }.buttonStyle(MButton.DefaultButton(isActive: true, invert: true,padding: 8))
        }
        .padding(18)
        .modifier(MView.Card())
    }
}

struct CProfileBiodata_Previews: PreviewProvider {
    static var previews: some View {
        CProfileBiodata()
    }
}
