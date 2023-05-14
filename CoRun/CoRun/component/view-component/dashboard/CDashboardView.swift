//
//  CDashboardView.swift
//  CoRun
//
//  Created by Marselus Richard on 30/03/23.
//

import SwiftUI

///CDashboardView
///Custom view for create and edit training session
struct CDashboardView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var pvm: TraineeCalendarViewModel
    
    @State var ownId:String
    @State var traineeId:String
    
    @State var showOptional = false
    @StateObject var vm = CDashboardViewModel()
    
    var body: some View {
        VStack(spacing:0){
            VStack(spacing:24){
                //MARK: Date
                VStack(alignment:.leading){
                    Text("Date")
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.DisabledText())
                    Text(TDate().dateToString(date: vm.session.date,format: "dd MMMM YYYY"))
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                }
                .modifier(MView.FillToLeftFrame())
                
                CTextfield(title: "Activity Title", hint: "Activity", input: $vm.dashboardDD.title)
                
                Button{
                    withAnimation{
                        showOptional.toggle()
                    }
                }label: {
                    HStack(spacing:24){
                        VStack{Divider()}
                        Group{
                            if showOptional{
                                Text("Hide Optional")
                            }
                            else{
                                Text("Show Optional")
                            }
                        }
                        .modifier(MFont.Caption1())
                        .modifier(MColor.Text())
                        .modifier(MView.FillFrame())
                        VStack{Divider()}
                    }
                }
            }
            .modifier(MView.safePadding())
            
            if showOptional{
                ScrollView{
                    VStack(spacing:24){
                        //MARK: Goal
                        VStack(spacing:12){
                            //MARK: Target Distance
                            CTextfield(title: "Target Distance",hint:"--",unit: "km",type: .decimal, input: $vm.dashboardDD.targetDistance)
                            
                            //MARK: Duration
                            HStack(spacing:18){
                                //MARK: Hour
                                CTextfield(title: "Duration",hint:"--",unit: "hour",type: .number, input: $vm.dashboardDD.targetDurationHour)
                                
                                //MARK: minute
                                CTextfield(title: "",hint:"--",unit: "min",type: .number, input: $vm.dashboardDD.targetDurationMin)
                            }
                            
                            //MARK: Pace
                            HStack(spacing:18){
                                //MARK: Target Min
                                CTextfield(title: "Target Pace",hint:"--",unit: "\'",type: .number, input: $vm.dashboardDD.targetPaceMin)
                                
                                //MARK: Target Pace Sec
                                CTextfield(title: "",hint:"--",unit: "\"",type: .number, input: $vm.dashboardDD.targetPaceSec)
                            }
                            
                            //MARK: Target Intensity
                            CTextfield(title: "Target Intensity",hint:"--",unit: "%",type: .number, input: $vm.dashboardDD.targetIntensity)
                            
                            //MARK: Desc
                            CTextfield(title: "Description",hint:"description",unit: "", input: $vm.dashboardDD.desc)
                        }
                        .modifier(MView.safePadding())
                        
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            //MARK: Button List
            VStack(spacing: 0){
                Button{
                    //TODO: Save Session Feature
                    if vm.isDataValid(){
                        pvm.isPostingSession = true
                    }
                }label: {
                    if pvm.isPostingSession{
                        ProgressView()
                            .progressViewStyle(.circular)
                    }else{
                        Text("Save Session")
                            .modifier(MFont.Headline(size:18))
                            .modifier(MColor.Primary())
                            .modifier(MView.FillToLeftFrame())
                    }
                }.buttonStyle(MButton.ListButton())
                
                Button{
                    //TODO: Discard Session Feature
                    pvm.isDeletingSession = true
                }label: {
                    if pvm.isDeletingSession{
                        ProgressView()
                            .progressViewStyle(.circular)
                    }else{
                        Text("Discard")
                            .modifier(MFont.Headline(size:18))
                            .modifier(MColor.Danger())
                            .modifier(MView.FillToLeftFrame())
                    }
                }.buttonStyle(MButton.ListButton())
                
            }
        }
        .onAppear{
            if pvm.selectedSession.activityName != ""{
                vm.session = pvm.selectedSession
                
                if pvm.selectedSession.target.count>0{
                    showOptional = true
                }
            }
            else{
                vm.session.date = pvm.selectedSession.date
                showOptional = true
            }
            vm.loadData()
        }
        .onChange(of: pvm.isPostingSession){ isPost in
            if isPost{
                pvm.isPostingSession = true
                Task{
                    let d = vm.validateData(ownId:ownId,traineeId: traineeId)
                    
                    await pvm.postSession(data: d)
                    
                    pvm.isPostingSession = false
                    pvm.updateSession = true
                    dismiss()
                }
            }        }
        .onChange(of: pvm.isDeletingSession){isDiscard in
            if isDiscard{
                pvm.isDeletingSession = true
                Task{
                    await pvm.deleteSession(sessionId: pvm.selectedSession.id)
                    
                    pvm.isDeletingSession = false
                    pvm.updateSession = true
                    dismiss()
                }
            }
        }
        .alert(vm.dataInvalidMessage, isPresented: $vm.showDataInvalidAlert){
            Button("OK", role: .cancel){}
        }
        .padding(.top,18)
        .modifier(MView.Card()).navigationTitle("Create Session")
    }
}

//struct CDashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CDashboardView()
//    }
//}
