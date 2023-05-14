//
//  TraineeViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import Foundation

class TraineeViewModel:ObservableObject{
    private let uapi = UserAPI()
    private let sapi = SessionAPI()
    private let tapi = TraineeAPI()
    private let group = DispatchGroup()
    
    @Published var selectedTab = "Summary"
    @Published var tabList = ["Calendar", "Summary"]
    
    @Published var pubTrainee = ProfileDisplayData()
    private var bufferTrainee = ProfileData()
    
    @Published var pubSes = [SessionDisplayData()]
    private var bufferSes = [SessionData()]
    
    
    func refreshDisplayData(){
        let p = ProfileDisplayData()
        
        p.id = bufferTrainee.UserId
        p.weight = Int(bufferTrainee.Weight)
        p.height = Int(bufferTrainee.Height)
        p.gender = bufferTrainee.Gender
        p.birthday = TDate().stringToDate(date: bufferTrainee.Birthday,format: "YYYY-MM-dd")
        p.coachName = ""
        
        pubTrainee = p
        
        pubSes.removeAll()
        for data in bufferSes{
            let s = SessionDisplayData()
            s.id = data.SessionId
            s.activityName = data.Name
            s.desc = data.Description
            s.status = CompletionStatus(status: data.Status)
            s.date = TDate().stringToDate(date: data.SessionDate,format: "YYYY-MM-dd")
            s.target = [
                TargetDisplayData(type: 0 ,amount: data.Duration),
                TargetDisplayData(type: 1 , amount: data.Distance),
                TargetDisplayData(type: 2, amount: data.Pace),
                TargetDisplayData(type: 3, amount: data.Intensity)
            ]

            s.isUnread = false
            
            s.status = CompletionStatus(status: data.Status)
            
            pubSes.append(s)
        }
        
        objectWillChange.send()
    }
    
    func loadBuffer(traineeId:String ,completion:@escaping()->Void){
        
        group.enter()
        uapi.GetUserData(userId: traineeId){ result in
            switch result{
            case .failure(_):
                print(">> TraineeViewModel: LoadBuffer: GetUserData Failed")
            case .success(let data):
                self.bufferTrainee = data
                print(">> TraineeViewModel: LoadBuffer: GetUserSession [\(data.Username)]")
            }
            self.group.leave()
        }
        
        group.enter()
        sapi.getUserSession(userId: traineeId){result in
            switch result{
            case .failure(_):
                print(">> TraineeViewModel: LoadBuffer: GetUserSession Failed")
            case .success(let data):
                self.bufferSes = data
                print(">> TraineeViewModel: LoadBuffer: GetUserSession [\(data.count)]")
            }
            self.group.leave()
        }
        
        self.group.notify(queue: .main){
            print("\n>> TraineeViewModel: LoadBuffer [\(traineeId)] : DONE \n")
            self.refreshDisplayData()
            completion()
        }
        //generateDummy()
    }
}
