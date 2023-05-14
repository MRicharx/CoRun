//
//  TraineeView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeView: View {
    @EnvironmentObject var own:ProfileData
    let traineeId: String
    let traineeName: String
    
    @State var isDisplayingPreview = false
    @StateObject var vm = TraineeViewModel()
    
    @State var isLoaded = false
    
    var body: some View {
        VStack{
            CTabControl(tab: $vm.selectedTab,title: "\(traineeName) Plan",tabList: vm.tabList)
            
            if isLoaded{
                ScrollView{
                    switch(vm.selectedTab){
                    case "Calendar":
                        TraineeCalendarView(isPreview: $isDisplayingPreview)
                    case "Summary":
                        TraineeSummaryView(isPreview: $isDisplayingPreview)
                    default:
                        Text("NaN")
                    }
                    
                    Spacer()
                }
            }
            else{
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
                Spacer()
            }
        }
        .environmentObject(vm)
        .onAppear{
            Task{
                vm.loadBuffer(traineeId:traineeId){
                    isLoaded = true
                }
            }
        }
    }
}

//struct TraineeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TraineeView()
//    }
//}
