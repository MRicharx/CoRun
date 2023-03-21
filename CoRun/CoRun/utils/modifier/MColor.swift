//
//  MColor.swift
//  CoRun
//
//  Created by Marselus Richard on 17/03/23.
//

import SwiftUI

///MColor - Modifier Color
///This modifier return foreground color for view component
class MColor{
    ///Define all used color in the app
    struct ColorPalette{
    let alert = Color("Alert")
    let danger = Color("Danger")
    
    let base=Color("Base")
    let card = Color("Card")
    let shade = Color("Shade")
    let separator = Color("Separator")
    
    let primary = Color("Primary")
    
    let textDefault = Color("TextDefault")
    let textDisabled = Color("TextDisabled")
}
    
    ///View Default Background Color
    struct Base:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().base)
        }
    }
    ///Card View Default Background Color
    struct Card:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().card)
        }
    }
    ///Shadow Color for float effect
    struct Shade:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().shade)
        }
    }
    ///Separator line Default Color
    struct Separator:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().separator)
        }
    }
    ///Alert bright yellow color
    struct Alert:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().alert)
        }
    }
    ///Warning bright red color
    struct Danger:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().danger)
        }
    }
    ///Primary green color
    struct Primary:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().primary)
        }
    }
    ///Text Color
    struct Text:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().textDefault)
        }
    }
    ///Disbled Text Color
    struct DisabledText:ViewModifier{
        func body(content:Content) -> some View{
            content
                .foregroundColor(ColorPalette().textDisabled)
        }
    }
}
