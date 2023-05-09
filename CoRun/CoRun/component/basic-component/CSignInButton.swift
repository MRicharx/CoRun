//
//  CSignInButton.swift
//  CoRun
//
//  Created by Marselus Richard on 02/04/23.
//

import Foundation
import SwiftUI
import AuthenticationServices

///CSignInButton : Wrap dedicated sign in button view from UIKit
struct CSignInButton: View{
    var api = UserAPI()
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                if let appleIdCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                    let uuid = appleIdCredential.user
                    //TODO: ASSIGN DATA HERE
                    
//                    self.vmLogin.uuid = uuid
//                    self.vmLogin.userLoginData = AutheticationRequest(uuid: uuid, name: "", tokenPushNotif: AppSetting.shared.tokenPushNotif)
//                    self.vmLogin.userLogin()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

///DEPRECATED
//struct CSignInButton: UIViewRepresentable {
//    @Environment(\.colorScheme) var colorScheme
//
//  typealias UIViewType = ASAuthorizationAppleIDButton
//
//  func makeUIView(context: Context) -> UIViewType {
//      return ASAuthorizationAppleIDButton(type: .signIn,style: colorScheme == .dark ? .white : .black)
//  }
//
//  func updateUIView(_ uiView: UIViewType, context: Context) {
//  }
//}
