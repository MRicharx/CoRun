//
//  MFont.swift
//  CoRun
//
//  Created by Marselus Richard on 16/03/23.
//

import SwiftUI

///MFont - Modifier Font
///This modifier return modifier for text style
///which include font size, font color, and font style
class MFont{
    ///Bold - 64
    struct Hero:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Bold"
        var size = 64
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Bold - 48
    struct Title:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Bold"
        var size = 48
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Semibold - 42
    struct Title1:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Semibold"
        var size = 42
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Semibold - 36
    struct Title2:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Semibold"
        var size = 36
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Semibold - 24
    struct Headline:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Semibold"
        var size = 24
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Regular - 24
    struct Body:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay"
        var size = 24
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Regular - 18
    struct SubBody:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay"
        var size = 18
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Thin - 16
    struct Caption1:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Thin"
        var size = 16
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
    ///Thin - 14
    struct Caption2:ViewModifier{
        var isItalic : Bool = false
        let font = "SFProDisplay-Thin"
        var size = 14
        
        func body(content:Content) -> some View{
            if(isItalic){
                content
                    .font(.custom(String(font+"Italic"), size: CGFloat(size),relativeTo: .headline))
            }else{
                content
                    .font(.custom(String(font), size: CGFloat(size),relativeTo: .headline))
            }
        }
    }
}


enum FontStyle{
    
}
