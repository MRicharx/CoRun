//
//  ContentView.swift
//  CoRun
//
//  Created by Marselus Richard on 16/03/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    @StateObject var splashStatus = SplashStatus()
    
    ///Define selected View
    @State var curView = ViewList.splash
    
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
        .onAppear{
            splashStatus.set(newStatus: .splash)
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
