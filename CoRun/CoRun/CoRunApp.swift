//
//  CoRunApp.swift
//  CoRun
//
//  Created by Marselus Richard on 16/03/23.
//

import SwiftUI
import BackgroundTasks

@main
struct CoRunApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase
//    let persistenceController = PersistenceController.shared
    
    private let notification = HNotification()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate)
                .onChange(of: scenePhase){ phase in
                    switch phase{
                    case .active:
                        print(">> Scene: active")
                    case .background:
//                        appDelegate.scheduleAppRefresh()
                        print(">> Scene: background")
                    case .inactive:
                        print(">> Scene: inactive")
                    default:
                        break
                    }
                }
//                .onAppear{
//                    notification.scheduleTask()
//                    notification.registerNotificationToken(token: appDelegate.deviceToken)
//                }
        }
    }
}
