//
//  CDivider.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import SwiftUI

///CDivider - Custom Divider
///Custom component for divider
///Parameter consist of color, weight and orientation of the component
struct CDivider: View {
    ///Define component orientation
    var isHorizontal:Bool = true
    ///Define divider weight
    var weight: Double = 2
    ///Define divider color
    var color: Color = MColor.ColorPalette().separator
    ///Define corner radius
    var cornerRadius:CGFloat = 1
    
    var body:some View{
        if(isHorizontal){
            Rectangle()
                .fill(color)
                .frame(minWidth:0, maxWidth:.infinity,minHeight:CGFloat(weight), maxHeight: CGFloat(weight))
                .cornerRadius(cornerRadius)
        }else{
            Rectangle()
                .fill(color)
                .frame(minWidth:CGFloat(weight), maxWidth:CGFloat(weight),minHeight: 0,maxHeight: .infinity)
                .cornerRadius(cornerRadius)
        }
    }
}
