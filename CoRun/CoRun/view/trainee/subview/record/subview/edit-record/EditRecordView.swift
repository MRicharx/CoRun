//
//  EditRecordPopUp.swift
//  CoRun
//
//  Created by Marselus Richard on 20/06/23.
//

import SwiftUI

struct EditRecordView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var record:RecordDisplayData
    var traineeId:String
    
    @EnvironmentObject var own:ProfileData
    @StateObject var vm = EditRecordViewModel()
    
    var body: some View {
        VStack{
            TextField(vm.hint, text: $vm.content, axis: .vertical)
                .textFieldStyle(.plain)
            Spacer()
            
            HStack(spacing:24){
                if Int(record.id) != 0{
                    Button{
                        //TODO: POST Record
                        if !(vm.isLoading){
                            vm.isLoading = true
                            vm.isDeleting = true
                        }
                    }label: {
                        Group{
                            if vm.isLoading && vm.isDeleting{
                               ProgressView()
                                    .progressViewStyle(.circular)
                            }
                            else{
                                Image(systemName: "trash.fill")
                            }
                        }.modifier(MFont.Headline(size:18))
                    }.buttonStyle(MButton.SquareButton(isActive: vm.isValid, color: MColor.ColorPalette().danger))
                }
                
                Button{
                    //TODO: POST Record
                    if vm.isValid{
                        if !(vm.isLoading){
                            vm.isLoading = true
                            vm.isPosting = true
                        }
                    }
                }label: {
                    Group{
                        if vm.isLoading && vm.isPosting{
                           ProgressView()
                                .progressViewStyle(.circular)
                        }
                        else if Int(record.id) == 0{
                            Text("Post Record")
                        }
                        else{
                            Text("Edit Record")
                        }
                    }.modifier(MFont.Headline(size:18))
                }.buttonStyle(MButton.DefaultButton(isActive: vm.isValid))
            }
        }
        .padding(24)
        .onChange(of:vm.content){ data in
            if data.count>0{
                vm.isValid = true
            }
            else{
                vm.isValid = false
            }
        }
        .onChange(of: vm.isLoading){ new in
            if new {
                if vm.isPosting{
                    vm.postRecord(
                        recordId: Int(record.id) ?? 0,
                    traineeId: traineeId,
                    writer: own.Username){
                        dismiss()
                    }
                }
                else{
                    vm.deleteRecord(recordId: Int(record.id) ?? 0){
                        dismiss()
                    }
                }
            }
        }
        .onAppear(){
            if record.content != ""{
                vm.content = record.content
            }
        }
    }
}

//struct EditRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecordView()
//    }
//}
