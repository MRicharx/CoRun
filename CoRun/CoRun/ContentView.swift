//
//  ContentView.swift
//  CoRun
//
//  Created by Marselus Richard on 16/03/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    ///Define selected View
    @State var curView = ViewList.splash
    ///Define is app onloading state
    @State var isOnLoading = false
    ///Define user profile data
    @StateObject var own = ProfileData()
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            switch(curView){
            case .splash:
                SplashView()
            case .assessment:
                AssessmentView()
            case .healthPermission:
                HealthPermissionView()
            case .home:
                TabView{
                    TrainingView()
                        .tabItem{
                            Label("Training",systemImage: "figure.run")
                        }
                    ProfileView()
                        .tabItem{
                            Label("Profile",systemImage: "person.fill")
                        }
                }
            }
        }
        .environment(\.selectedView, $curView)
        .environment(\.onLoading, $isOnLoading)
        .environmentObject(own)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
