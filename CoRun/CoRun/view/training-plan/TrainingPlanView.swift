//
//  TrainingPlanView.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct TrainingPlanView: View {
    @State var displayOption:String = "rectangle.grid.1x2"
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment:.leading, spacing: 28){
                    //MARK: Title
                    Text("Training\nPlan")
                        .modifier(MView.safePadding())
                        .modifier(MColor.Text())
                        .modifier(MFont.Title())
                    
                    //MARK: Segmented Control
                    CSegmented(option: ["rectangle.grid.1x2","rectangle.grid.3x2"], selected: $displayOption,isSFSymbol: true)
                    
                    //MARK: Tab Navigator
                    //TODO: Implement this
                    HStack{
                        Group{
                            Button{
                                //TODO: Implement Previous Navigation
                            }label: {
                                Image(systemName: "chevron.left")
                                    .modifier(MColor.Primary())
                            }
                            
                            Text("This Week")
                                .modifier(MColor.Text())
                                .modifier(MView.FillFrame())
                            
                            Button{
                                //TODO: Implement Next Navigation
                            }label: {
                                Image(systemName: "chevron.right")
                                    .modifier(MColor.Primary())
                            }
                        }.modifier(MFont.Headline(size: 18))
                    }.modifier(MView.safePadding())
                    
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
                    
                }.modifier(MView.FillFrame())
            }
        }
    }
}

struct TrainingPlanView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingPlanView()
    }
}
