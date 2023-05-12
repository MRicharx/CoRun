//
//  ScanQRVM.swift
//  CoRun
//
//  Created by Marselus Richard on 12/05/23.
//

import Foundation

class ScanQRViewModel:ObservableObject{
    private let uapi = UserAPI()
    
    ///Define Target Coach
    @Published var coachName = ""
    
    ///Define Request Alert Behavior
    @Published var showRequestAlert = false
    ///Define success alert
    @Published var showSuccessAlert = false
    
    func sendRequest(ownId:String,coachId:String) async{
        await withCheckedContinuation{ send in
            uapi.SendCoachRequest(userId: ownId, coachId: coachId){success in
                if success{
                    print(">> Sending coach request to \(coachId) success")
                }
                else{
                    print(">> Sending coach rewuest failed")
                }
                self.showSuccessAlert = true
                send.resume()
            }
        }
    }
    
    func retrieveCoach(id:String) async{
        await withCheckedContinuation{ retrieve in
            uapi.GetUserData(userId: id){result in
                switch result{
                case.failure(_):
                    print(">> Failed retrieving coach data")
                    self.coachName = ""
                    retrieve.resume()
                case .success(let data):
                    print(">> Retrieved Coach \(data.Username)")
                    self.coachName = data.Username
                    retrieve.resume()
                }
            }
        }
    }
}
