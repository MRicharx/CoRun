//
//  SplashView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct SplashView: View {
    @Environment(\.selectedView) private var curView
    @StateObject var AuthHandler = HAuthentication()
    
    ///Define sign in behavior
    @State private var showSignInButton = false
    ///Define Self ViewModel
    @State private var vm = SplashViewModel()
    
    var body: some View {
        NavigationStack{
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

                if (showSignInButton){
                    CSignInButton()
                        .frame(maxHeight: 48)
                        .onTapGesture{
                            //TODO: Sign In Feature
                            vm.signIn()
                            
                            curView.wrappedValue = vm.defineNextView()
                        }
                }else{
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
            .task{
                vm.toggleLoading()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    if !(vm.isSignedIn()){
                        withAnimation{
                            showSignInButton = true
                        }
                    }
                    else{
                        curView.wrappedValue = vm.defineNextView()
                    }
                }
            }
            .padding(36)
        }
    }
}

//struct SplashView_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashView()
//    }
//}
