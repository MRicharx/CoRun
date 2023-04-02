//
//  SplashView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct SplashView: View {
    ///Define current view state
    /// 0 - Booting App,
    /// 1- Signing In,
    /// 2 - Directing to Assestment,
    /// 3 - Checking HealthKit Permission,
    /// else - Directing to Home (All requirement fulfilled)
    @State var viewState = 0
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            VStack(spacing: 36){
                //MARK: App Logo
                Circle()
                    .modifier(MColor.Primary())
                
                if(viewState == 1){
                    //MARK: Sign In Button
                    CSignInButton()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 64)
                        .onTapGesture {
                            //TODO: Sign In Feature
                        }
                }
            }
        }
        .padding(24)
        .onAppear{
            //TODO: Check is Signed and requirement thing
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
