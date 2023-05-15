//
//  CoRunApp.swift
//  CoRun
//
//  Created by Marselus Richard on 16/03/23.
//

import SwiftUI

@main
struct CoRunApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
