//
//  TraineeView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeView: View {
    @StateObject var vm = TraineeViewModel()
    
    var body: some View {
        VStack{
            CTabControl(tab: $vm.selectedTab,title: "\(vm.traineeData.username) Plan",tabList: ["Calendar", "Summary"])
            
            ScrollView{
                switch(vm.selectedTab){
                case "Calendar":
                    TraineeCalendarView()
                case "Summary":
                    TraineeSummaryView()
                default:
                    Text("NaN")
                }
                
                Spacer()
            }
        }
    }
}

struct TraineeView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeView()
    }
}
