//
//  SplashView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.selectedView) private var curView
    @EnvironmentObject private var own:ProfileData
    
    ///Define Self ViewModel
    @StateObject private var vm = SplashViewModel()
    ///Define sign in status
    @State var isSigned = false
    ///Define if device getting registered
    @State var isRegistered = false
    ///Define is system on loading and show loading screen
    @State var showLoadingScreen = false
    
    var body: some View {
        VStack(spacing: 72){
            VStack(spacing: 0){
                //MARK: App Logo
                Image("LogoCropped")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 120)
                
                Text("CoRun")
                    .modifier(MFont.Title(size: 36))
                    .modifier(MColor.Primary())
            }
            
            if isRegistered{
                VStack{
                    ProgressView()
                        .progressViewStyle(.circular)
                    Text("Progress View")
                        .modifier(MFont.Caption1())
                        .modifier(MColor.DisabledText())
                }
            }
            else if vm.isLoading{
                ProgressView()
                    .progressViewStyle(.circular)
            }else{
                CSignInButton(isSigned: $isSigned)
                    .frame(maxHeight: 48)
            }
        }
        .onChange(of: isSigned){ new in
            if new{
                print(">> Sign Success")
                vm.isLoading = true
                vm.getProfileData(id: SharedToken.shared.SignInToken){ result in
                    own.set(new: result)
                    
                    vm.checkDeviceToken(current: SharedToken.shared.NotificationToken, ownId: own.UserId)
                    
                    curView.wrappedValue = vm.defineNextView(userData: own)
                    vm.isLoading = false
                }
            }
            else{
                print(">> Sign Failed")
            }
        }
        //MARK: Check if token existed
        .task{
            vm.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                if SharedToken.shared.SignInToken == ""{
                    withAnimation{
                        if vm.defineNextView() != ViewList.splash{
                            curView.wrappedValue = vm.defineNextView()
                        }
                        else{
                            vm.isLoading = false
                        }
                    }
                }
                else{
                    vm.getProfileData(id: SharedToken.shared.SignInToken){ result in
                        own.set(new: result)
                        vm.isLoading = false
                        curView.wrappedValue = vm.defineNextView(userData: own)
                    }
                }
            }
        }
        .padding(36)
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
