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
    let tapi = TraineeAPI()
    
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
            var temp = SessionData()
            temp.UserId = "1"
            temp.CoachId = "4"
            temp.SessionDate = "2023-5-10"
            temp.Name = "roti bakar"
            temp.Description = "des"
            temp.Status = 3
            temp.Duration = 10
            temp.Distance = 10
            temp.Pace = 10
            temp.Intensity = 70
            
            tapi.dismissTrainee(traineeId:"4", coachId: "1"){success in
                if success{
                    print("Berhasil")
                }else{
                    print("Gagal")
                }
            }
            tapi.getTraineeSession(traineeId: <#T##String#>, completion: <#T##(Result<[SessionData], ErrorMessage>) -> Void#>)
        }
        .environment(\.selectedView, $curView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
