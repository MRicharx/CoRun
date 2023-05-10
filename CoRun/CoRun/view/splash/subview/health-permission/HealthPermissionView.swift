//
//  HealthPermissionView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct HealthPermissionView: View {
    @Environment(\.selectedView) var curView
    @EnvironmentObject private var own:ProfileData
    
    //Define self view model
    @StateObject var vm = HealthPermissionViewModel()
    
    var body: some View {
        ZStack{
            Color("Base")
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
                    if !(vm.isLoading){
                        vm.requestHealthPermission()
                    }
                }label:{
                    Group{
                        if vm.isLoading{
                            ProgressView()
                                .progressViewStyle(.circular)
                        }else{
                            Text("Grant Access")
                                .modifier(MColor.Base())
                        }
                    }
                    .modifier(MFont.Headline())
                }.buttonStyle(MButton.DefaultButton(isActive: true))
            }
        }
        .onChange(of: vm.askDone){_ in
            withAnimation{
                curView.wrappedValue = vm.defineNextView(userData: own)
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
