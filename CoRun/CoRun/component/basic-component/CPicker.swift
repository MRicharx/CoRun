//
//  CPicker.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI

struct CPicker: View {
    let dateHandler = TDate()
    
    ///Define reminder activeness
    @Binding var isReminderActive:Bool
    ///Define selected time in date
    @Binding var currentReminder:Date
    ///State DatePicker Display Behavior
    @State var showPicker = false
    ///Define date picker result value
    @State var pickerValue = Date.now
    
    var body: some View {
        VStack{
            //MARK: Custom Date Picker
            if(showPicker){
                VStack{
                    DatePicker("", selection: $pickerValue, displayedComponents: .hourAndMinute)
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
                                currentReminder = pickerValue
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
            else{
                Button {
                    withAnimation{
                        if(isReminderActive){
                            showPicker = true
                        }
                        else{
                            isReminderActive = true
                            showPicker = true
                        }
                    }
                }  label: {
                    if(isReminderActive){
                        Text(dateHandler.dateToString(date: currentReminder,format: "HH:mm"))
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                    }
                    else{
                        Text(dateHandler.dateToString(date: currentReminder,format: "HH:mm"))
                            .modifier(MFont.Headline())
                            .modifier(MColor.DisabledText())
                    }
                }
            }
        }
    }
}

//struct CPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CPicker()
//    }
//}
