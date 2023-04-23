//
//  TraineeView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeView: View {
    @State var isDisplayingPreview = false
    @StateObject var vm = TraineeViewModel()
    
    var body: some View {
        VStack{
            CTabControl(tab: $vm.selectedTab,title: "\(vm.traineeData.username) Plan",tabList: ["Calendar", "Summary"])
            
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
        .onAppear{
            if isDisplayingPreview == true{
                vm.selectedTab = "Summary"
            }
        }
    }
}

struct TraineeView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeView()
    }
}
