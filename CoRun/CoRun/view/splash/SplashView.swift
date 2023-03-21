//
//  SplashView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        VStack{
            Circle()
                .modifier(MColor.Primary())
        }.padding(24)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
