//
//  CBirthdayPicker.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import SwiftUI

///CDatePicker - Custom DatePicker
///Custom component for Date Picker
struct CDatePicker: View {
    ///Picker title on top left
    let title:String

    ///Binded input value
    @Binding var input:Date
    
    @State var textColor = MColor.ColorPalette().textDefault
    @State private var showPicker = false
    @State private var pickerValue = Date.now
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8){
            Text(title)
                .modifier(MFont.Caption1())
                .modifier(MColor.DisabledText())
                .modifier(MView.FillToLeftFrame())
            
            VStack(spacing:2){
                HStack{
                    Group{
                        Text(TDate().dateToString(date: input,format: "dd / MMMM / YYYY"))
                            .modifier(MView.FillToLeftFrame())
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(textColor)
                    .modifier(MFont.Body())
                }
                .onTapGesture {
                    withAnimation{
                        showPicker = true
                    }
                }
                
                //MARK: Custom Date Picker
                if showPicker{
                    VStack{
                        DatePicker("", selection: $pickerValue, displayedComponents: .date)
                            .datePickerStyle(.wheel)
                        HStack(spacing: 18){
                            Button{
                                withAnimation{
                                    showPicker = false
                                }
                            }label: {
                                Text("Cancel")
                                    .modifier(MFont.Headline(size:16))
                            }.buttonStyle(MButton.DefaultButton(isActive: true,invert: true,padding: 8))
                            Button{
                                withAnimation{
                                    input = pickerValue
                                    showPicker = false
                                }
                            }label: {
                                Text("OK")
                                    .modifier(MFont.Headline(size:16))
                            }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 8))
                        }
                    }
                    .modifier(MView.FillFrame())
                }
            }
        }
        .modifier(MView.FillFrame())
        .onChange(of: input){ new in
            ///Max Char Limit
            if(input > Date.now){
                input = Date.now
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
