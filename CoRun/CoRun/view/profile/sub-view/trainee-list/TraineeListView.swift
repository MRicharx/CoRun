//
//  TraineeListView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeListView: View {
    @EnvironmentObject var own:ProfileData
    @StateObject var vm = TraineeListViewModel()
    
    var body: some View {
        VStack{
            //MARK: Search Bar
            VStack{
                CSearchBar(hint: "Find Trainee",input: $vm.searchInput)
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 18, trailing: 24))
            .modifier(MView.Card())
            
            //MARK: Request Section
            VStack{
                Button{
                    withAnimation{
                        vm.showAllRequest.toggle()
                    }
                }label:{
                    HStack(){
                        Text("Request (\(vm.requestList.count))")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.Text())
                            .modifier(MView.FillToLeftFrame())
                        
                        Group{
                            if(vm.showAllRequest){
                                Text("Hide")
                            }else{
                                Text("Show All")
                            }
                        }
                        .modifier(MFont.SubBody())
                        .modifier(MColor.Primary())
                    }
                }.buttonStyle(MButton.ListButton())
                
                if(vm.showAllRequest){
                    VStack(spacing:0){
                        ScrollView{
                            ForEach(vm.requestList.indices, id:\.self){ i in
                                Group{
                                    NavigationLink{
                                        TraineeView(traineeId: vm.requestList[i].id,traineeName: vm.requestList[i].username,isDisplayingPreview: true)
                                    }label:{
                                        CTraineeCard(traineeData: vm.requestList[i])
                                    }
                                    CDivider()
                                }.padding(EdgeInsets(top: 4, leading: 24, bottom: 4, trailing: 24))
                            }
                        }
                    }
                    .frame(maxHeight: 360)
                }
            }
            .modifier(MView.Card())
            
            //MARK: Trainee List
            VStack{
                ScrollView{
                    ForEach(vm.traineeList.indices, id:\.self){ i in
                        Group{
                            NavigationLink{
                                TraineeView(traineeId: vm.traineeList[i].id,traineeName: vm.traineeList[i].username)
                            }label:{
                                CTraineeCard(traineeData: vm.traineeList[i])
                            }
                            CDivider()
                        }.padding(EdgeInsets(top: 4, leading: 24, bottom: 4, trailing: 24))
                    }
                }
            }
            .modifier(MView.Card())
        }
        .onChange(of: vm.searchInput){q in
            vm.refreshDisplayData()
        }
        .navigationTitle("My Trainee")
        .task{
            await vm.loadBuffer(userId: own.UserId)
            
            vm.refreshDisplayData()
        }
        .environmentObject(vm)
    }
}

struct TraineeListView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeListView()
    }
}
