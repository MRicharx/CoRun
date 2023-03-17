//
//  MView.swift
//  CoRun
//
//  Created by Marselus Richard on 17/03/23.
//

import SwiftUI

///MView - Modifier View
///This modifier return modifier for view component in certain matter
class MView{
    ///Set view to fill frame horizontally
    struct FillFrame:ViewModifier{
        func body(content: Content) -> some View {
            content
                .frame(minWidth:0,maxWidth: .infinity)
        }
    }
    
    
}
