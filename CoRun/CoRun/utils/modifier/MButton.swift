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
        var padding:Int = 8
        
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
                        .background(MColor.ColorPalette().primaryDisabled)
                        .foregroundColor(MColor.ColorPalette().shade)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    ///Set button to fill frame horizontally with Danger color
    struct DangerButton: ButtonStyle {
        let isActive:Bool
        var invert:Bool = false
        var padding:Int = 8
        
        func makeBody(configuration: Configuration) -> some View {
            if(isActive){
                if(invert){
                    configuration.label
                        .padding(CGFloat(padding))
                        .frame(minWidth:0,maxWidth: .infinity)
        //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                        .background(MColor.ColorPalette().card)
                        .foregroundColor(MColor.ColorPalette().danger)
                        .cornerRadius(10)
                        .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(MColor.ColorPalette().danger, lineWidth: 2)
                            )
                        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
                }else{
                    configuration.label
                        .padding(CGFloat(padding))
                        .frame(minWidth:0,maxWidth: .infinity)
        //                .background(configuration.isPressed ? MColor.ColorPalette().primary : ColorPalette.init().accentOrange)
                        .background(MColor.ColorPalette().danger)
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
                                RoundedRectangle(cornerRadius: 8)
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
    
    ///Set button with list style effect
    struct ListButton:ButtonStyle{
        var padding:CGFloat = 8
        var dividerWeight:CGFloat = 2
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
                .frame(minWidth:0,maxWidth: .infinity)
                .background(configuration.isPressed ? MColor.ColorPalette().separator:MColor.ColorPalette().card)
                .overlay(
                        Rectangle()
                            .stroke(MColor.ColorPalette().separator, lineWidth: CGFloat(dividerWeight))
                            .padding(EdgeInsets(top: 0, leading: -1*(dividerWeight), bottom: 0, trailing: -1*dividerWeight)
                    ))
        }
    }
}
