//
//  TraineeCalendarView.swift
//  CoRun
//
//  Created by Marselus Richard on 14/04/23.
//

import SwiftUI

struct TraineeCalendarView: View {
    @Binding var isPreview : Bool
    @StateObject var vm = TraineeCalendarViewModel()
    
    var body: some View {
        VStack(spacing:12){
            CCalendarView(data: ListSessionDisplayData(list: vm.sessionDD))
            
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
                        if vm.selectedSession.status.enume != .planNotDone{
                            //MARK: Feedback
                            Button{
                                //TODO: Navigate to Feedback
                            }label:{
                                HStack{
                                    Text("Feedback")
                                        .modifier(MFont.SubBody())
                                        .modifier(MColor.Text())
                                        .modifier(MView.FillToLeftFrame())
                                    Image(systemName: "chevron.right")
                                        .modifier(MFont.SubBody())
                                        .modifier(MColor.DisabledText())
                                }
                            }.buttonStyle(MButton.ListButton())
                        }
                        if vm.selectedSession.status.enume != .planNotDone && vm.selectedSession.date >= Date.now{
                            //MARK: Delete
                            Button{
                                //TODO: Delete Feature
                            }label:{
                                HStack{
                                    Text("Delete Session")
                                        .modifier(MFont.Headline(size:18))
                                        .modifier(MColor.Danger())
                                        .modifier(MView.FillToLeftFrame())
                                }
                            }.buttonStyle(MButton.ListButton())
                        }
                        if vm.selectedDate >= Date.now{
                            //MARK: Create/Edit
                            NavigationLink{
                                CDashboardView(date: vm.selectedDate)
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
        .onChange(of: vm.selectedDate){ newDate in
            let d = newDate
            vm.findSession(byDate: d)
        }
        .onAppear{
            if vm.sessionDD.isEmpty{
                vm.loadSession()
            }
        }
        .environment(\.selectedDate, $vm.selectedDate) //Set environment object
    }
}

//struct TraineeCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TraineeCalendarView()
//    }
//}
