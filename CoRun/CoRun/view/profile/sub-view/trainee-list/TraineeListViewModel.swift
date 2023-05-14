//
//  TraineeListViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import Foundation

class TraineeListViewModel:ObservableObject{
    private let tapi = TraineeAPI()
    
    ///Define search value
    @Published var searchInput = ""
    ///Define request section visibility
    @Published var showAllRequest = false
    ///Define list of trainee
    @Published var traineeList = [TraineeDisplayData]()
    ///Define list of request
    @Published var requestList = [TraineeDisplayData]()
    
    private var bufferList = [TraineeData]()
    private var reqHolder = 0
 
    func refreshDisplayData(){
        traineeList.removeAll()
        requestList.removeAll()
        
        for data in bufferList{
            let d = TraineeDisplayData()
            d.id = data.UserId
            d.username = data.Username
            d.birthday = TDate().stringToDate(date: data.Birthday, format: "YYYY-MM-dd")
            d.gender = data.Gender
            d.height = data.Height
            d.weight = data.Weight
            
            let u = data.Username.lowercased()
            let q = searchInput.lowercased()
            
            ///Apply search query
            if searchInput == "" || u.contains(q){
                if data.Status == 0{
                    d.isRequest = true
                    requestList.append(d)
                }
                else{
                    d.isRequest = false
                    traineeList.append(d)
                }
            }
        }
        
        objectWillChange.send()
    }
    
    func loadBuffer(userId:String) async{
        bufferList.removeAll()
        
        await withCheckedContinuation{ load in
            tapi.getTrainee(userId: userId){ result in
                switch result{
                case .failure(_):
                    print(">> TraineeListViewModel: loadBuffer: getTrainee Failed")
                case .success(let data):
                    self.bufferList = data
                }
                load.resume()
            }
        }
        
//        generateDummy()
        
    }
    
    func acceptReq(traineeId:String, ownId:String) async{
        await withCheckedContinuation{ accept in
            tapi.acceptTrainee(traineeId: traineeId, coachId: ownId){ success in
                if success{
                    print(">> TraineeListViewModel: acceptReq: [\(traineeId)] request accepted")
                }
                else{
                    print(">> TraineeListViewModel: acceptReq: failed accepting")
                }

                accept.resume()
            }
        }
    }
    func declineReq(traineeId:String, ownId:String) async{
        reqHolder+=1
        await withCheckedContinuation{ decline in
            tapi.declineTrainee(traineeId: traineeId, coachId: ownId){ success in
                if success{
                    print(">> TraineeListViewModel: declineReq: [\(traineeId)] request declined")
                }
                else{
                    print(">> TraineeListViewModel: declineReq: failed declining")
                }
                
                decline.resume()
            }
        }
    }
    
    private func generateDummy(){
        for i in 1...3{
            let temp = TraineeDisplayData()
            temp.id = "\(i)r"
            temp.username = "Budi\(i)"
            temp.birthday = TDate().stringToDate(date: "10/March/200\(i)",format: "dd/MMMM/YYYY")
            temp.gender = "Male"
            temp.height = 170+i
            temp.weight = 50+i
            temp.isRequest = true
            
            requestList.append(temp)
        }
        
        for i in 1...8{
            let temp = TraineeDisplayData()
            temp.id = "\(i)r"
            temp.username = "Budi\(i)"
            temp.birthday = TDate().stringToDate(date: "10/March/200\(i)",format: "dd/MMMM/YYYY")
            temp.gender = "Male"
            temp.height = 170+i
            temp.weight = 50+i
            
            traineeList.append(temp)
        }
    }
}
