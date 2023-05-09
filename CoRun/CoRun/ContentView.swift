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
    
    let api = UserAPI()
    let sapi = SessionAPI()
    
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
        .task{
            var temp = FeedbackData()
            temp.id = 1
            temp.senderID = "1"
            temp.content = "Bertaring lah dragonball"
            temp.sentDate = "2023-10-20"
            sapi.getSessionFeedback(sessionId: 1){result in
                switch result{
                case .failure(_):
                    print("Broken")
                case .success(let data):
                    
                    print(data.count)
                    for d in data{
                        print(d.content)
                    }
                }
            }
            
//            sapi.getUserSession(userId:"1"){res in
//                switch res{
//                case .success(let data):
//                    print(data[0].SessionId)
//                case .failure(_):
//                    print("Failed")
//                }
//            }
        }
        .environment(\.selectedView, $curView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
