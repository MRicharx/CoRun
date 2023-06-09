//
//  Segmented.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import SwiftUI

///CSegmented - Custom segmented
///Custom component for segmented control
///Parameter consist of avaiable option and selected option
struct CSegmented: View {
    ///Segmented Control option
    var option:[String]
    
    ///Binded option
    @Binding var selected:String
    
    var body: some View {
        HStack{
            ForEach(option, id:\.self){ opt in
                if(opt == selected){
                    Button{
                        //MARK: Button Function
                        ///DO NOTHING
                    }label: {
                        VStack{
                            Text(opt)
                            .modifier(MFont.SubBody())
                            .modifier(MColor.Base())
                        }
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .modifier(MView.FillFrame())
                        .background(MColor.ColorPalette().primary)
                        .cornerRadius(8)
                    }
                }
                else{
                    Button{
                        //MARK: Button Function
                        selected = opt
                    }label: {
                        VStack{
                            Text(opt)
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                        }
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .modifier(MView.FillFrame())
                    }
                }
            }
        }
        .modifier(MView.FillFrame())
        .cornerRadius(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                    .stroke(MColor.ColorPalette().separator, lineWidth: 2)
                    .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
            ))
    }
}

//struct Segmented_Previews: PreviewProvider {
//    static var previews: some View {
//        CSegmented(option: ["Week","Month","Year"], selected: "Week")
//    }
//}
