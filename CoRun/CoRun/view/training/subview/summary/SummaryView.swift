//
//  SummaryView.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import SwiftUI

struct SummaryView: View {
    ///Define View's ViewModel
    @StateObject var vm = SummaryViewModel()
    
    var body: some View {
        VStack(spacing:12){
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
                        .frame(minHeight: 360,maxHeight: 360)
                }
            }
            .padding(24)
            .modifier(MView.Card())
            
            Spacer()
        }
        .onAppear{
            vm.loadData()
        }
        .onChange(of:vm.displayOption){ new in
            vm.updateDisplayOption(dp: new)
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
