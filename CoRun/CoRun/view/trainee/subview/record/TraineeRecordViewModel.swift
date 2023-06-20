//
//  TraineeRecordViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 19/06/23.
//

import Foundation

class TraineeRecordViewModel:ObservableObject{
    private let tapi = TraineeAPI()
    
    @Published var showEditRecord = false
    @Published var pubRecord = [RecordDisplayData()]
    private var bufferRecord = [RecordData()]
    
    @Published var selectedRecord = RecordDisplayData()
    
    @Published var refresh = false
    
    init(){
        pubRecord.removeAll()
    }
    
    func refreshDisplayData(){
        pubRecord.removeAll()
        selectedRecord = RecordDisplayData()
        
        for data in bufferRecord{
            let d = RecordDisplayData(data: data)
            pubRecord.append(d)
        }
        
        refresh = false
    }
    
    func loadBuffer(userId:String, completion:@escaping()-> Void){
        bufferRecord.removeAll()
        
        //TODO: Implement GET API
        tapi.getRecord(traineeId: userId){ result in
            switch(result){
            case .failure(_):
                print(">> TraineeRecordViewModel: GetRecord Failed")
            case .success(let data):
                self.bufferRecord = data
            }
            print(">> TraineeRecordViewModel: Record Loaded: Total Data: [\(self.bufferRecord.count)]")
            completion()
        }
    }
}
