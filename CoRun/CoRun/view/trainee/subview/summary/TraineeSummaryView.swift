//
//  TraineeSummaryView.swift
//  CoRun
//
//  Created by Marselus Richard on 14/04/23.
//

import SwiftUI

struct TraineeSummaryView: View {
    @Binding var isPreview : Bool
    @StateObject var vm = TraineeSummaryViewModel()
    
    var body: some View {
        VStack(spacing:12){
            //MARK: Biodata
            VStack(alignment: .leading,spacing: 18){
                Text("Biodata")
                    .padding(EdgeInsets(top: 18, leading: 24, bottom: 0, trailing: 24))
                    .modifier(MFont.Headline(size:16))
                    .modifier(MColor.DisabledText())
                
                //MARK: Data
                VStack(spacing: 12){
                    HStack{
                        Text(vm.traineeData.username)
                            .modifier(MFont.Headline(size:18))
                            .modifier(MColor.Text())
                        Text("\(TDate().getUserAge(birth: vm.traineeData.birthday)) Years Old")
                            .modifier(MFont.Body(size:18))
                            .modifier(MColor.Text())
                    }.modifier(MView.FillToLeftFrame())
                    HStack{
                        HStack{
                            Image(systemName: "scalemass.fill")
                                .modifier(MColor.Primary())
                            Text("\(vm.traineeData.weight) kg")
                                .modifier(MColor.Text())
                        }.modifier(MView.FillToLeftFrame())
                        HStack{
                            Image(systemName: "ruler.fill")
                                .modifier(MColor.Primary())
                            Text("\(vm.traineeData.height) cm")
                                .modifier(MColor.Text())
                        }.modifier(MView.FillToLeftFrame())
                        HStack{
                            Text("BMI")
                                .modifier(MFont.Title(size:18))
                                .modifier(MColor.Primary())
                            Text("\(vm.countBMI(height: vm.traineeData.height, weight: vm.traineeData.weight))")
                                .modifier(MColor.Text())
                        }.modifier(MView.FillToLeftFrame())
                    }
                }.modifier(MView.safePadding())
                
                if isPreview{
                    VStack(spacing:0){
                        //MARK: Accept Button
                        Button{
                            //TODO: Accept Request
                        }label:{
                            Text("Accept")
                                .modifier(MFont.Headline(size:18))
                                .modifier(MColor.Primary())
                                .modifier(MView.FillToLeftFrame())
                        }.buttonStyle(MButton.ListButton())
                        //MARK: Decline Button
                        Button{
                            //TODO: Decline Request
                        }label:{
                            Text("Decline")
                                .modifier(MFont.Headline(size:18))
                                .modifier(MColor.Danger())
                                .modifier(MView.FillToLeftFrame())
                        }.buttonStyle(MButton.ListButton())
                    }
                }
                else{
                    //MARK: Dismiss Button
                    Button{
                        //TODO: Dismiss Trainee
                    }label:{
                        Text("Dismiss")
                            .modifier(MFont.Headline(size:18))
                            .modifier(MColor.DisabledText())
                            .modifier(MView.FillToLeftFrame())
                    }.buttonStyle(MButton.ListButton())
                }
            }
            .modifier(MView.FillToLeftFrame())
            .modifier(MView.Card())
            
            //MARK: Graph
            VStack(spacing:24){
                //MARK: Segmented Control
                CSegmented(option: vm.listOption, selected: $vm.displayOption)
                
                //MARK: Navigator
                HStack{
                    Group{
                        Image(systemName: "chevron.left")
                            .onTapGesture{
                                vm.prev()
                            }
                            .modifier(MColor.Primary())
                        
                        Group{
                            switch(vm.displayOption){
                            case "Week":
                                Text(vm.weekRange())
                            case "Month":
                                Text(TDate().dateToString(date: vm.currentDate,format:"MMMM YYYY"))
                            case "Year":
                                Text(TDate().dateToString(date: vm.currentDate,format:"YYYY"))
                            default:
                                Text("Overall Data")
                            }
                        }.modifier(MView.FillFrame())
                        
                        Image(systemName: "chevron.right")
                            .onTapGesture{
                                vm.next()
                            }
                            .modifier(MColor.Primary())
                    }.modifier(MFont.SubBody())
                }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                
                //MARK: Summary Data
                HStack{
                    //MARK: Total Run
                    VStack{
                        Text(String(vm.totalRun))
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Total Run")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                    
                    //MARK: Avg Pace
                    VStack{
                        Text(TDate().secondToPace(seconds: vm.avgPace))
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Avg. Pace")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                    
                    //MARK: Run Time
                    VStack{
                        Text(TDate().getStringinHMS(seconds: vm.runTime))
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Run Time")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                }
                
                VStack(alignment: .leading,spacing: 12){
                    CDivider()
                    HStack{
                        Text("Total Distance")
                            .modifier(MColor.Text())
                            .modifier(MFont.Headline(size:16))
                        Text("(km)")
                            .modifier(MColor.DisabledText())
                            .modifier(MFont.Body(size:16))
                    }
                    Text(String(vm.distanceRan))
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                    
                    //MARK: Distance Graph
                    CGraph(data: vm.graphData)
                        .frame(maxHeight: 240)
                }
            }
            .padding(24)
            .modifier(MView.Card())
        }
    }
}

//struct TraineeSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        TraineeSummaryView()
//    }
//}
