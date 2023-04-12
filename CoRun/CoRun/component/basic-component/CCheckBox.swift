//
//  CheckBox.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

///CCheckbox - Custom CheckBox
///Custom component in form of check box
///Parameter consist of checkbox title, description, and avaiable option
struct CCheckBox: View {
    ///Textfield title on top left
    let title:String
    ///Textfield title on top right
    var desc:String = ""
    ///Checkbox option
    var option:[String]
    
    ///Binded option
    @Binding var selected:String
    
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
            
            //MARK: List Generation
            HStack{
                ForEach(option, id: \.self){ opt in
                    if(opt == selected){
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
                            selected = opt
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
