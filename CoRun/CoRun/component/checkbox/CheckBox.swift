//
//  CheckBox.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

struct CheckBox: View {
    ///Textfield title on top left
    let title:String
    ///Textfield title on top right
    var desc:String = ""
    ///Checkbox option
    var option:[String] = []
    
    ///Binded option
    @Binding var input:String
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Group{
                    Text(title)
                    Spacer()
                    Text(desc)
                }
                .modifier(MColor.DisabledText())
                .modifier(MFont.Caption1())
            }
            
            HStack{
                ForEach(option, id: \.self){ opt in
                    if(opt == input){
                        Button{
                            //TODO: Do function
                            ///Do NOTHING I GUESS
                        } label:{
                            Group{
                                Circle()
                                    .frame(width: 16, height: 16)
                                Text(opt)
                                    .modifier(MFont.Body())
                            }.modifier(MColor.DisabledText())
                        }
                    }
                    else{
                        Button{
                            //TODO: Do function
                            input = opt
                        } label:{
                            Circle()
                                .strokeBorder(MColor.ColorPalette().textDisabled, lineWidth: 2)
                                .frame(width: 16, height: 16)
                            Text(opt)
                                .modifier(MFont.Body())
                                .modifier(MColor.DisabledText())
                        }
                    }
                }
            }
            
        }.modifier(MView.FillFrame())
    }
}

//struct CheckBox_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckBox()
//    }
//}
