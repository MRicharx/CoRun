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
    @Environment(\.selectedView) private var curView
    @Binding var isSigned:Bool
    
    var api = UserAPI()
    
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
            switch result {
            case .success(let authResults):
                if let appleIdCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                    let signData = SignInData()
                    signData.uuid = appleIdCredential.user
                    signData.email = appleIdCredential.email ?? "No Data"
                    
                    //MARK: ASSIGN DATA to user defaultHERE
                  api.SignInWithAppleID(body: signData){result in
                    switch result{
                    case .failure(_):
                        print("SIGN IN ERROR")
                    case .success(let data):
                        SharedToken.shared.SignInToken = data.UserId
                        
                        //MARK: Signing in Success
                        if data.UserId != ""{
                            isSigned = true
                        }
                    }
                }
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
