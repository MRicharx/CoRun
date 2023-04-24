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
    @State var date:Date
    @StateObject var vm = CDashboardViewModel()
    
    var body: some View {
        VStack(spacing:0){
            VStack(spacing:24){
                //MARK: Date
                VStack(alignment:.leading){
                    Text("Date")
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.DisabledText())
                    Text(TDate().dateToString(date: date,format: "dd MMMM YYYY"))
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                }
                .modifier(MView.FillToLeftFrame())
                
                CTextfield(title: "Activity Title", input: $vm.dashboardDD.title)
                
                HStack(spacing:24){
                    CDivider()
                    Text("Optional")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                    CDivider()
                }
            }
            .modifier(MView.safePadding())
            
            ScrollView{
                VStack(spacing:24){
                    //MARK: Goal
                    VStack(spacing:12){
                        //MARK: Target Distance
                        CTextfield(title: "Target Distance",hint:"--",unit: "km",type: .number, input: $vm.dashboardDD.targetDistance)
                        
                        //MARK: Pace
                        HStack(spacing:18){
                            //MARK: Target Pace
                            CTextfield(title: "Target Pace",hint:"--",unit: "\'",type: .number, input: $vm.dashboardDD.targetPaceMin)
                            
                            //MARK: Target Distance
                            CTextfield(title: "",hint:"--",unit: "\"",type: .number, input: $vm.dashboardDD.targetPaceSec)
                        }
                        
                        //MARK: Duration
                        HStack(spacing:18){
                            //MARK: Hour
                            CTextfield(title: "Duration",hint:"--",unit: "hour",type: .number, input: $vm.dashboardDD.targetDurationHour)
                            
                            //MARK: minute
                            CTextfield(title: "",hint:"--",unit: "min",type: .number, input: $vm.dashboardDD.targetDurationMin)
                        }
                        
                        //MARK: Target Intensity
                        CTextfield(title: "Target Intensity",hint:"--",unit: "%",type: .number, input: $vm.dashboardDD.targetIntensity)
                        
                        //MARK: Desc
                        CTextfield(title: "Description",hint:"",unit: "",type: .number, input: $vm.dashboardDD.desc)
                    }
                    .modifier(MView.safePadding())
                    
                    //MARK: Button List
                    VStack(spacing: 0){
                        Button{
                            //TODO: Save Session Feature
                        }label: {
                            Text("Save Session")
                                .modifier(MFont.Headline(size:18))
                                .modifier(MColor.Primary())
                                .modifier(MView.FillToLeftFrame())
                        }.buttonStyle(MButton.ListButton())
                        
                        Button{
                            //TODO: Discard Session Feature
                        }label: {
                            Text("Discard")
                                .modifier(MFont.Headline(size:18))
                                .modifier(MColor.Danger())
                                .modifier(MView.FillToLeftFrame())

                        }.buttonStyle(MButton.ListButton())
                        
                    }
                    
                    Spacer()
                }
            }
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
