//
//  TextField.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import SwiftUI

///CTextFiield - Custom TextField
///Custom component for textfield
///Parameter consist of textfield title, description, hint and unit, all of these are optional except title
struct CTextfield: View {
    ///Textfield title on top left
    let title:String
    ///Textfield title on top right
    var desc:String = ""
    ///Textfield default fill
    var hint:String = ""
    ///Textfield input unit
    var unit:String = ""
    
    ///Binded input value
    @Binding var input:String
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Group{
                    Text(title)
                        .modifier(MFont.Headline(size:16))
                    Spacer()
                    Text(desc)
                        .modifier(MFont.Caption1())
                }
                .modifier(MColor.DisabledText())
            }
            
            ZStack{
                HStack{
                    ZStack{
                        if(input==""){
                            Text(hint)
                                .modifier(MColor.Shade())
                                .modifier(MFont.Body())
                                .modifier(MView.FillToLeftFrame())
                        }
                        TextField("", text: $input)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)
                        .accentColor(MColor.ColorPalette().primary)
                        .modifier(MFont.Body())
                        .modifier(MColor.Text())
                    }
                    .modifier(MView.FillToLeftFrame())
                    
                    Text(unit)
                        .modifier(MColor.DisabledText())
                        .modifier(MFont.Headline())
                }
            }
            .modifier(MView.FillFrame())
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(MColor.ColorPalette().textDisabled, lineWidth: 2)
            )
        }.modifier(MView.FillFrame())
    }
}

//struct TextField_Previews: PreviewProvider {
//    @State var name = "Enna"
//    
//    static var previews: some View {
//        TextField(title: "Text Field",desc: "description", hint: "Hint", input: $name)
//    }
//}
