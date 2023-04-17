//
//  PopUpAlertKey.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation
import SwiftUI

///Store pop up status for alert
private struct NotificationPermissionAlertKey:EnvironmentKey{
    static let defaultValue:Binding<Bool> = .constant(false)
}

extension EnvironmentValues{
    var notificationPermissionAlert: Binding<Bool>{
        get { self[NotificationPermissionAlertKey.self] }
        set { self[NotificationPermissionAlertKey.self] = newValue }
    }
}
