//
//  SessionDetailView.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct SessionDetailView: View {
    @StateObject private var vm = SessionDetailViewModel()
    @ObservedObject var data: SessionDisplayData
    
    var body: some View {
        ZStack{
            Color("Base")
                .ignoresSafeArea()
            
            VStack(spacing:12){
                CSessionTitle(data:data)
                
                ScrollView{
                    VStack(spacing: 12){
                        CSessionGoal(data: data)
                        CSessionResult(vm:vm, result: data.result)
                        CSessionFeedback(showAll: $vm.showAllFeedback)
                    }.padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
                }
            }
        }
        .onAppear{
            vm.checkResult(data: data)
        }
        .sheet(isPresented: $vm.showAllFeedback){
            CChatView(displayOption: .full)
        }
    }
}

//struct SessionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionDetailView()
//    }
//}
