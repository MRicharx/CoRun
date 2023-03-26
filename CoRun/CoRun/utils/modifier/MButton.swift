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
        var invert:Bool = false
        var padding:Int = 18
        
        func makeBody(configuration: Configuration) -> some View {
            if(isActive){
                if(invert){
                    configuration.label
                        .padding(CGFloat(padding))
                        .frame(minWidth:0,maxWidth: .infinity)
        //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                        .background(MColor.ColorPalette().card)
                        .foregroundColor(MColor.ColorPalette().primary)
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(MColor.ColorPalette().primary, lineWidth: 2)
                            )
                        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                }else{
                    configuration.label
                        .padding(CGFloat(padding))
                        .frame(minWidth:0,maxWidth: .infinity)
        //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                        .background(MColor.ColorPalette().primary)
                        .foregroundColor(MColor.ColorPalette().base)
                        .cornerRadius(10)
                        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                }
            }
            else{
                if(invert){
                    configuration.label
                        .padding(CGFloat(padding))
                        .frame(minWidth:0,maxWidth: .infinity)
        //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                        .background(MColor.ColorPalette().base)
                        .foregroundColor(MColor.ColorPalette().shade)
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(MColor.ColorPalette().shade, lineWidth: 2)
                            )
                    
                }else{
                    configuration.label
                        .padding(CGFloat(padding))
                        .frame(minWidth:0,maxWidth: .infinity)
        //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                        .background(MColor.ColorPalette().base)
                        .foregroundColor(MColor.ColorPalette().shade)
                        .cornerRadius(10)
                }
            }
        }
    }
}
