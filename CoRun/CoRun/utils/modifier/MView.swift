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
    
    ///Set view to have card with drop shadow effect
    struct Card:ViewModifier{
        ///Define card corner radius
        var cornerRadius:CGFloat = 24
        ///Define translation on drop shadow effect
        var translation:CGFloat = 0
        ///Define shadow radius
        var shadowRadius:CGFloat = 4
        
        func body(content: Content) -> some View {
            content
                .frame(minWidth:0,maxWidth: .infinity)
                .background(MColor.ColorPalette().card)
                .cornerRadius(cornerRadius)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                .background(
                    MColor.ColorPalette().shade
                        .cornerRadius(cornerRadius)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                    .shadow(color: MColor.ColorPalette().shade, radius: 0, x: translation, y: translation)
                    .blur(radius: shadowRadius, opaque: false)
                )
        }
    }
    
    ///Set safe area for view
    struct safePadding:ViewModifier{
        func body(content: Content) -> some View {
            content
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
        }
    }
    
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
