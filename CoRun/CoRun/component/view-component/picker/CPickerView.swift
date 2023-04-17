//
//  CPicker.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI

struct CPickerView: View {
    let dateHandler = TDate()
    let notification = HNotification()
    
    ///Define view model
    @StateObject var vm = CPickerViewModel()
    
    var body: some View {
        VStack{
            HStack(alignment:.top, spacing:12){
                Image(systemName: "alarm.fill")
                    .modifier(MColor.Primary())
                    .modifier(MFont.Body())
                Group{
                    VStack(alignment:.leading,spacing: 8){
                        HStack{
                            Text("Daily Reminder")
                                .modifier(MColor.Text())
                                .modifier(MView.FillToLeftFrame())
                            Toggle("",isOn: $vm.isReminderActive)
                                .onChange(of: vm.isReminderActive){ new in
                                    withAnimation{
                                        if vm.getPermission() == .granted{
                                            vm.toggleReminder()
                                        }else{
                                            vm.checkPermission()
                                        }
                                    }
                                }
                        }
                        
                        //MARK: Custom Date Picker
                        if(vm.showPicker){
                            VStack{
                                DatePicker("", selection: $vm.pickerValue, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(.wheel)
                                HStack(spacing: 18){
                                    Button{
                                        withAnimation{
                                            vm.showPicker = false
                                        }
                                    }label: {
                                        Text("Cancel")
                                            .modifier(MFont.Headline(size:16))
                                    }.buttonStyle(MButton.DefaultButton(isActive: true,invert: true,padding: 8))
                                    Button{
                                        withAnimation{ vm.scheduleReminder()
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
                            if vm.isReminderActive{
                                Text(dateHandler.dateToString(date: vm.reminderValue,format: "HH:mm"))
                                    .modifier(MFont.Headline())
                                    .modifier(MColor.Text())
                            }
                            else{
                                Text(dateHandler.dateToString(date: vm.reminderValue,format: "HH:mm"))
                                    .modifier(MFont.Headline())
                                    .modifier(MColor.DisabledText())
                            }                        }
                    }
                }
                .modifier(MFont.SubBody())
            }
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
        .buttonStyle(MButton.ListButton())
        .onTapGesture {
            withAnimation{
                vm.checkPermission()
            }
        }
    }
    
}

//struct CPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CPicker()
//    }
//}
