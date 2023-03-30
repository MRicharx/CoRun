//
//  TraineeListView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeListView: View {
    ///Define search value
    @State var searchInput:String = ""
    ///Define request section visibility
    @State var requestVisibility:Bool = true
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 24){
                //MARK: Title
                Text("My Trainee")
                    .modifier(MView.safePadding())
                    .modifier(MColor.Text())
                    .modifier(MFont.Title())
                
                //MARK: Search Bar
                CSearchBar(hint: "Find Trainee",input: $searchInput)
                    .modifier(MView.safePadding())
                
                //MARK: Request Section
                VStack{
                    HStack(alignment:.firstTextBaseline){
                        Text("Request")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                            .modifier(MView.FillToLeftFrame())
                        
                        //MARK: Request visibility trigger
                        Button{
                            withAnimation{
                                requestVisibility.toggle()
                            }
                        }label: {
                            Group{
                                if(requestVisibility){
                                    Text("Hide")
                                }else{
                                    Text("Show All Request")
                                }
                            }.modifier(MColor.Primary())
                        }
                    }
                    .modifier(MView.safePadding())
                    
                    //MARK: Request List
                    //TODO: Load Request List
                    if(requestVisibility){
                        VStack(spacing: 18){
                            CTraineeCard(isRequest: true)
                            CTraineeCard(isRequest: true)
                            CTraineeCard(isRequest: true)
                        }
                    }
                }
                
                //MARK: Trainee Section
                VStack{
                    Text("Trainee")
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                        .modifier(MView.FillToLeftFrame())
                        .modifier(MView.safePadding())
                    
                    //MARK: Trainee List
                    VStack(spacing: 18){
                        CTraineeCard()
                        CTraineeCard()
                        CTraineeCard()
                    }
                }
                
            }
        }.modifier(MView.FillToLeftFrame())
    }
}

struct TraineeListView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeListView()
    }
}
