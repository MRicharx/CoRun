//
//  TrainingView.swift
//  CoRun
//
//  Created by Marselus Richard on 11/04/23.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.onLoading) var isOnLoading
    @EnvironmentObject var own: ProfileData
    
    ///Define selected tab
    @State var selectedTab  = "Loading"
    ///Define own view vm
    @StateObject var vm = TrainingViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing:12){
                CTabControl(tab: $selectedTab)
                
                switch(selectedTab){
                case "Plan":
                    PlanView()
                case "Calendar":
                    CalendarView()
                case "Summary":
                    SummaryView()
                default:
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
            }
        }
        .onAppear{
            isOnLoading.wrappedValue = true
            
            Task{
                await vm.getSession()
                await vm.getWorkoutData()
                
                vm.matchSession(age: TDate().getUserAge(birth: TDate().stringToDate(date: own.Birthday)))
                
                if vm.updateResult{
                    await vm.postResult()
                    await vm.getSession()
                    vm.updateResult = true
                }
                
                vm.loadBuffer()
                
                isOnLoading.wrappedValue = false
                selectedTab = "Plan"
            }
        }
        .environmentObject(vm)
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
