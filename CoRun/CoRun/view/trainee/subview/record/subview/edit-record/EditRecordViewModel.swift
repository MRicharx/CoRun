//
//  EditRecordViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/06/23.
//

import Foundation

class EditRecordViewModel:ObservableObject{
    private var tapi = TraineeAPI()
    
    @Published var content = ""
    var hint = "Insert Trainee Record Here"
    
    @Published var isValid = false
    @Published var isLoading = false
    @Published var isPosting = false
    @Published var isDeleting = false
    @Published var dismissNotifier = false
    
    func postRecord(recordId:Int = 0, traineeId:String = "",writer:String = "",completion:@escaping()->Void){
        let body = RecordData()
        body.recordId = recordId
        body.content = content
        body.writer = writer
        body.date = TDate().dateToString(date: Date.now, format: "YYYY/MM/dd HH:mm:ss")
        
        tapi.postRecord(body: body, traineeId: traineeId){ result in
            if result{
                completion()
            }
            else{
                print(">> EditRecordViewModel: PostRecord: FAILED")
                completion()
            }
        }
    }
    
    func deleteRecord(recordId:Int, completion:@escaping()->Void){
        tapi.deleteRecord(recordId: recordId){ result in
            if result{
                completion()
            }
            else{
                print(">> EditRecordViewModel: DeleteRecord: FAILED")
                completion()
            }
        }
    }
    
}
