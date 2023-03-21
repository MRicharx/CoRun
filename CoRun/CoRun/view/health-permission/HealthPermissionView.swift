//
//  HealthPermissionView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct HealthPermissionView: View {
    var body: some View {
        ZStack{
            Color("base")
                .ignoresSafeArea()
            
            VStack(spacing: 24){
                Spacer()
                
                Image("health")
                    .resizable()
                    .frame(maxWidth:128,maxHeight: 128)
                Text("This App require access\nto Health app for:")
                    .modifier(MColor.Text())
                    .modifier(MFont.Headline())
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 4){
                    Text("\u{2022} Read and share your workout record")
                        .modifier(MColor.Text())
                        .modifier(MFont.SubBody())
                    Text("\u{2022} Read and share your medical data")
                        .modifier(MColor.Text())
                        .modifier(MFont.SubBody())
                }
                
                Spacer()
                
                Button{
                    //TODO: DO Thing
                }label:{
                    Text("Grant Access")
                        .modifier(MFont.Headline())
                        .modifier(MColor.Base())
                }.buttonStyle(MButton.DefaultButton(isActive: true))
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
    }
}

struct HealthPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        HealthPermissionView()
    }
}
