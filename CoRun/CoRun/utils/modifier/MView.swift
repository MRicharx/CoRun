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
    let basePadding = 24
    
    ///Set view to fill frame horizontally
    struct FillFrame:ViewModifier{
        func body(content: Content) -> some View {
            content
                .frame(minWidth:0,maxWidth: .infinity)
        }
    }
    ///Set view to fill frame horizontally and align the content to left
    struct FillToLeftFrame:ViewModifier{
        func body(content: Content) -> some View {
            content
                .frame(minWidth:0,maxWidth: .infinity,alignment: .leading)
        }
    }
    
}
