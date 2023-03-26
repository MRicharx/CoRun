//
//  CProfileReminder.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct CProfileReminder: View {
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
        VStack(spacing: 18){
            //MARK: Title
            HStack(spacing : 12){
                Group{
                    Image(systemName: "alarm.waves.left.and.right.fill")
                        .modifier(MColor.Primary())
                    Text("Reminder")
                        .modifier(MColor.Text())
                        .modifier(MView.FillToLeftFrame())
                    
                    Toggle("", isOn: $isReminderActive)
                }.modifier(MFont.Headline())
            }
            .modifier(MView.FillToLeftFrame())
            
            //MARK: Content
            VStack(alignment:.leading,spacing: 6){
                Text("Reminder")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.DisabledText())
                
                //MARK: Custom Date Picker
                if(showPicker){
                    VStack{
                        DatePicker("", selection: $pickerValue, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                        HStack{
                            Button{
                                withAnimation{
                                    showPicker = false
                                }
                            }label: {
                                Text("Cancel")
                                    .modifier(MFont.Headline(size:16))
                            }.buttonStyle(MButton.DefaultButton(isActive: true,invert: true,padding: 4))
                            Button{
                                withAnimation{
                                    currentReminder = pickerValue
                                    showPicker = false
                                }
                            }label: {
                                Text("OK")
                                    .modifier(MFont.Headline(size:16))
                            }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 4))
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
            }.modifier(MView.FillToLeftFrame())
        }
        .onChange(of: isReminderActive){ newValue in
            if(!(newValue)){
                withAnimation{
                    showPicker = false
                }
            }
        }
        .padding(18)
        .modifier(MView.Card())
    }
}

//struct CProfileReminder_Previews: PreviewProvider {
//    static var previews: some View {
//        CProfileReminder()
//    }
//}
