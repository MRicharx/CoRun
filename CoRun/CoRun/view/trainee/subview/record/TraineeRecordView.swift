//
//  TraineeRecordView.swift
//  CoRun
//
//  Created by Marselus Richard on 19/06/23.
//

import SwiftUI

struct TraineeRecordView: View{
    @Binding var traineeId: String
    @EnvironmentObject var pvm : TraineeViewModel
    @StateObject var vm = TraineeRecordViewModel()
    
    var body: some View{
        VStack(spacing:24){
//            Circle()
//                .foregroundColor(MColor.ColorPalette().primary)
//                .frame(width: 128)
            
            if vm.pubRecord.count <= 0{
                Spacer()
                Text("No Record For This Trainee")
                    .modifier(MFont.Caption1())
                    .modifier(MColor.DisabledText())
                
                Button{
                    //TODO: Navigate to add record
                    vm.showEditRecord = true
                }label: {
                    Text("Add Record +")
                        .modifier(MFont.Headline(size:18))
                }
                .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
                .buttonStyle(MButton.DefaultButton(isActive: true))
                
                Spacer()
            }
            else{
                Button{
                    //TODO: Navigate to add record
                    vm.showEditRecord = true
                }label: {
                    Text("Add Record +")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.Primary())
                }
                .buttonStyle(MButton.ListButton())
                
                ForEach(vm.pubRecord.indices, id: \.self){ i in
                    let record = vm.pubRecord[i]
                    
                    CRecordCard(content: record.content, date: record.date, writer: record.writer)
                        .onTapGesture {
                            vm.selectedRecord = vm.pubRecord[i]
                            vm.showEditRecord = true
                        }
                    
                }
            }
        }
        .sheet(isPresented: $vm.showEditRecord){
            EditRecordView(record: $vm.selectedRecord,traineeId:traineeId)
        }
        .onChange(of: vm.showEditRecord){ cur in
            if !(cur){
                vm.loadBuffer(userId: traineeId){
                    vm.refresh = true
                }
            }
        }
        .onChange(of: vm.refresh){ new in
            vm.refreshDisplayData()
        }
        .onAppear(){
            vm.loadBuffer(userId: traineeId){
                vm.refresh = true
            }
        }
    }
}
