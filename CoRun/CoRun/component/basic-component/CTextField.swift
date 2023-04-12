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
    ///Define max char limit
    var maxChar = -1
    
    
    ///Define keyboard type
    @State var type: KeyboardType = .normal
    
    ///Binded input value
    @Binding var input:String
    
    enum KeyboardType{
        case normal
        case number
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8){
            HStack{
                Group{
                    Text(title)
                        .modifier(MFont.Caption1())
                    Spacer()
                    Text(desc)
                        .modifier(MFont.Caption1())
                }
                .modifier(MColor.DisabledText())
            }
            
            VStack(spacing:2){
                HStack{
                    ZStack{
                        if(input==""){
                            Text(hint)
                                .modifier(MColor.DisabledText())
                                .modifier(MFont.Body())
                                .modifier(MView.FillToLeftFrame())
                        }
                        
                        Group{
                            switch(type){
                            case .normal:
                                TextField("", text: $input)
                                    .modifier(MFont.Body())
                            case .number:
                                TextField("", text: $input)
                                .keyboardType(.numberPad)
                                .modifier(MFont.Body())
                            }
                        }
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)
                        .accentColor(MColor.ColorPalette().primary)
                        .modifier(MFont.Body())
                        .modifier(MColor.Text())
                    }
                    
                    Text(unit)
                        .modifier(MColor.DisabledText())
                        .modifier(MFont.Headline())
                }
                
                CDivider(weight: 1,color: MColor.ColorPalette().primaryDisabled,cornerRadius: 1)
            }
            
            ///Deprecated version
//            ZStack{
//                HStack{
//                    ZStack{
//                        if(input==""){
//                            Text(hint)
//                                .modifier(MColor.DisabledText())
//                                .modifier(MFont.Body())
//                                .modifier(MView.FillToLeftFrame())
//                        }
//                        Group{
//                            if(isKeyboardDefault){
//                                TextField("", text: $input)
//                            }else{
//                                TextField("", text: $input)
//                                .keyboardType(.numberPad)
//                            }
//                        }
//                        .textFieldStyle(PlainTextFieldStyle())
//                        .disableAutocorrection(true)
//                        .accentColor(MColor.ColorPalette().primary)
//                        .modifier(MFont.Body())
//                        .modifier(MColor.Text())
//                    }
//                    .modifier(MView.FillToLeftFrame())
//
//                    Text(unit)
//                        .modifier(MColor.DisabledText())
//                        .modifier(MFont.Headline())
//                }
//            }
//            .modifier(MView.FillFrame())
//            .padding(10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(MColor.ColorPalette().textDisabled, lineWidth: 2)
//            )
        }
        .modifier(MView.FillFrame())
        .onChange(of: input){ new in
            ///Max Char Limit
            if(maxChar>=0){
                input = String(new.prefix(maxChar))

            }
        }
    }
}

//struct TextField_Previews: PreviewProvider {
//    @State var name = "Enna"
//    
//    static var previews: some View {
//        TextField(title: "Text Field",desc: "description", hint: "Hint", input: $name)
//    }
//}
