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
struct CSignInButton: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    
  typealias UIViewType = ASAuthorizationAppleIDButton
  
  func makeUIView(context: Context) -> UIViewType {
      return ASAuthorizationAppleIDButton(type: .signIn,style: colorScheme == .dark ? .white : .black)
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) {
  }
}
