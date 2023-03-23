//
//  MButton.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

///MButton - Modifier Button
///This modifier return modifier for button style
class MButton{
    ///Set button to fill frame horizontally with accent color
    struct DefaultButton: ButtonStyle {
        let isActive:Bool
        
        func makeBody(configuration: Configuration) -> some View {
            if(isActive){
                configuration.label
                    .padding()
                    .frame(minWidth:0,maxWidth: .infinity)
    //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                    .background(MColor.ColorPalette().primary)
                    .foregroundColor(MColor.ColorPalette().base)
                    .cornerRadius(10)
                    .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            }
            else{
                configuration.label
                    .padding()
                    .frame(minWidth:0,maxWidth: .infinity)
    //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                    .background(MColor.ColorPalette().shade)
                    .foregroundColor(MColor.ColorPalette().textDisabled)
                    .cornerRadius(10)
                    .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            }
        }
    }
}
