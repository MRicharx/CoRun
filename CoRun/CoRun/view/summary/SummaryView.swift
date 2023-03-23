//
//  SummaryView.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        ZStack{
            Color("base")
                .ignoresSafeArea()
            
            ScrollView(){
                VStack(alignment:.leading, spacing: 28){
                    //MARK: Title
                    Text("My Run\nSummary")
                        .modifier(MView.safePadding())
                        .modifier(MColor.Text())
                        .modifier(MFont.Title())
                    
                    //MARK: Segmented Control
                    CSegmented(option: ["Week","Month","Year"], selected: "Week")
                    
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
                            
                            Text("This Month")
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
                .modifier(MView.FillFrame())
            }
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
