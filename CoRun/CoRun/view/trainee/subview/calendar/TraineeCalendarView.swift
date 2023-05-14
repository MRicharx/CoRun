//
//  TraineeCalendarView.swift
//  CoRun
//
//  Created by Marselus Richard on 14/04/23.
//

import SwiftUI

struct TraineeCalendarView: View {
    @EnvironmentObject var own:ProfileData
    @EnvironmentObject var pvm:TraineeViewModel
    
    @Binding var isPreview : Bool
    @StateObject var vm = TraineeCalendarViewModel()
    
    var body: some View {
        VStack(spacing:12){
            if vm.isLoaded{
                CCalendarView(data: ListSessionDisplayData(list: vm.sessionDD))
            }
            
            if !(isPreview){
                //MARK: Session View
                VStack{
                    //MARK: Session Detail
                    VStack{
                        CSessionCard(data: vm.selectedSession)
                    }
                    .padding(24)
                    
                    //MARK: Button List
                    VStack(spacing:0){
                        if vm.selectedDate >= vm.today{
                            //MARK: Create/Edit
                            NavigationLink{
                                CDashboardView(ownId: own.UserId, traineeId: pvm.pubTrainee.id)
                                    .environmentObject(vm)
                            }label:{
                                VStack(spacing:12){
                                    CDivider()
                                    Text("Create/Edit Session")
                                        .modifier(MFont.Headline(size:18))
                                        .modifier(MColor.Primary())
                                        .modifier(MView.FillToLeftFrame())
                                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                                    CDivider()
                                }
                            }
                        }
                    }
                }.modifier(MView.Card())
                Spacer()
            }
        }
        .onAppear{
            vm.sessionDD = pvm.pubSes
            vm.refreshDisplayData()
        }
        .onChange(of: vm.updateSession){ val in
            if val{
                Task{
                    vm.isLoaded = false
                    pvm.loadBuffer(traineeId: pvm.pubTrainee.id){
                        vm.sessionDD = pvm.pubSes
                        vm.updateSession = false
                        vm.isLoaded = true
                    }
                }
            }
        }
        .onChange(of: vm.selectedDate){ newDate in
            let d = newDate
            vm.findSession(byDate: d)
        }
        .environment(\.selectedDate, $vm.selectedDate) //Set environment object
    }
}

//struct TraineeCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TraineeCalendarView()
//    }
//}
