//
//  TraineeView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeView: View {
    ///Define which tab will be shown
    @State var viewOption:String = "Training Plan"
    ///Define how training plan will be displayed
    @State var displayOption:String = "rectangle.grid.1x2"
    ///Define how summary will be filtered
    @State var filterOption:String = "Week"
    
    var body: some View {
        ZStack{
            Color("base")
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment:.leading, spacing: 28){
                    //MARK: Title
                    Text("Trainee\nUsername")
                        .modifier(MView.safePadding())
                        .modifier(MColor.Text())
                        .modifier(MFont.Title())
                    
                    //MARK: Tab Segmented Control
                    CSegmented(option: ["Training Plan","Summary"], selected: $viewOption)
                    
                    VStack{
                        //MARK: Training Plan
                        if(viewOption == "Training Plan"){
                            //MARK: Display Option
                            CSegmented(option: ["rectangle.grid.1x2","rectangle.grid.3x2"], selected: $displayOption,isSFSymbol: true)
                            
                            //MARK: Training Plan View
                            if(displayOption == "rectangle.grid.1x2"){
                                VStack(spacing:18){
                                    CSessionCard()
                                    CSessionCard()
                                    CSessionCard()
                                }

                            }else{
                                VStack(spacing: 24){
                                    CCalendarCard()
                                    
                                    CSessionCard()
                                }
                            }
                        }
                        //MARK: Summary
                        else{
                            //MARK: Segmented Control
                            CSegmented(option: ["Week","Month","Year"], selected: $filterOption)
                            
                            //MARK: Summary Card
                            //TODO: Handle the data passing
                            CSummaryCard()
                            
                            //MARK: Activity Record
                            VStack(alignment:.leading,spacing:18){
                                Text("Activity Record")
                                    .modifier(MView.safePadding())
                                    .modifier(MFont.Headline())
                                    .modifier(MColor.Text())
                                
                                //TODO: Implement for loop for this component
                                CActivityCard()
                                CActivityCard()
                                CActivityCard()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct TraineeView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeView()
    }
}
