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
    @State var showAllRequest:Bool = true
    
    var body: some View {
        VStack{
            //MARK: Search Bar
            VStack{
                CSearchBar(hint: "Find Trainee",input: $searchInput)
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 18, trailing: 24))
            .modifier(MView.Card())
            
            //MARK: Request Section
            VStack{
                Button{
                    withAnimation{
                        showAllRequest.toggle()
                    }
                }label:{
                    HStack(){
                        Text("Request (X)")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.Text())
                            .modifier(MView.FillToLeftFrame())
                        
                        Group{
                            if(showAllRequest){
                                Text("Hide")
                            }else{
                                Text("Show All")
                            }
                        }
                        .modifier(MFont.SubBody())
                        .modifier(MColor.Primary())
                    }
                }.buttonStyle(MButton.ListButton())
                
                if(showAllRequest){
                    VStack(){
                        Group{
                            CTraineeCard(isRequest: true)
                            CDivider()
                            CTraineeCard(isRequest: true)
                            CDivider()
                            CTraineeCard(isRequest: true)
                            CDivider()
                        }
                    }.padding(24)
                }
            }
            .modifier(MView.Card())
            
            //MARK: Trainee List
            VStack{
                ScrollView{
                    Group{
                        CTraineeCard()
                        CDivider()
                        CTraineeCard()
                        CDivider()
                        CTraineeCard()
                        CDivider()
                        CTraineeCard()
                        CDivider()
                        CTraineeCard()
                        CDivider()
                    }.padding(24)
                }
            }
            .modifier(MView.Card())
        }
    }
}

struct TraineeListView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeListView()
    }
}
