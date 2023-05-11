//
//  TrainingPlanView.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct PlanView: View {
    @EnvironmentObject private var pvm : TrainingViewModel
    @StateObject var vm = PlanViewModel()
    
    var body: some View {
        VStack(spacing: 12){
            //MARK: Progress Bar
            VStack{
                HStack{
                    Text("To do this week")
                        .modifier(MFont.Headline(size: 18))
                        .modifier(MColor.Text())
                        .modifier(MView.FillToLeftFrame())
                    
                    Text("Completed \(vm.sessionPassed) of \(vm.sessionThisWeek)")
                        .modifier(MFont.Caption1())
                        .modifier(MColor.DisabledText())
                }
                HStack{
                    ForEach(0...vm.sessionThisWeek-1,id:\.self){ i in
                        if i < vm.sessionPassed{
                            CDivider(weight:4,color: MColor.ColorPalette().primary, cornerRadius: 4)
                        }else{
                            CDivider(weight:4,color: MColor.ColorPalette().textDisabled, cornerRadius: 4)
                        }
                    }
                }
            }
            .padding(24)
            .modifier(MView.Card())
            
            //MARK: Session List
            ScrollView{
                VStack(spacing: 24){
                    Spacer()
                        .frame(height:6)
                    if pvm.pubSes.count>0{
                        ForEach(vm.sessionDD.indices, id: \.self){ i in
                            NavigationLink{
                                SessionDetailView(data: vm.sessionDD[i])
                            }label: {
                                CSessionCard(data:vm.sessionDD[i])
                            }
                        }
                    }else{
                        Text("No session for this week")
                            .modifier(MColor.DisabledText())
                            .modifier(MFont.SubBody())
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
            .modifier(MView.Card())
        }
        .task {
            vm.loadSession(session: pvm.pubSes)
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
