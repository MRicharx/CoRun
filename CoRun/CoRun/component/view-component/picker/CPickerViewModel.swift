//
//  CPickerViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation
import SwiftUI

class CPickerViewModel:ObservableObject{
    @Environment(\.notificationPermissionAlert) var showPermissionAlert
    
    var notification = HNotification()
    
    @Published var reminderValue = Date.now
    @Published var pickerValue = Date.now
    @Published var showPicker = false
    @Published var isReminderActive = false
    //@Binding var showAlert:Bool
    
    init(){
        isReminderActive = SharedReminder.shared.isReminderActive
        reminderValue = SharedReminder.shared.ReminderValue
        pickerValue = reminderValue
    }
    func getPermission()->notificationPermissionResponse{
        return notification.permissionStatus
    }
    ///Check for notification permission and toggle picker status
    func checkPermission(){
        if notification.permissionStatus == .yetAsked{
            isReminderActive = false
            notification.requestPermission()
        }
        else if notification.permissionStatus == .denied{
            isReminderActive = false
            showPermissionAlert.wrappedValue = true
        }
        else if notification.permissionStatus == .granted{
            if(isReminderActive){
                showPicker = true
            }
            else{
                toggleReminder()
            }
        }
    }
    ///Toggle reminder status as well as update reminder status on user default
    func toggleReminder(){
        isReminderActive.toggle()
        SharedReminder.shared.isReminderActive = isReminderActive
        
        if isReminderActive==true{
            scheduleReminder()
        }
    }
    ///Toggle reminder value as well as update reminder value on user default and reschedule background task
    func scheduleReminder(){
        //TODO: Set scheduler
        reminderValue = pickerValue
        SharedReminder.shared.ReminderValue = pickerValue
//        notification.pushDummyNotification()
        
        showPicker = false
    }
}
