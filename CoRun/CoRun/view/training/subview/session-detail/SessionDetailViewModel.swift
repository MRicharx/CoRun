//
//  SessionDetailViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import Foundation

class SessionDetailViewModel:ObservableObject{
    private let uapi = UserAPI()
    private let sapi = SessionAPI()
    private let group = DispatchGroup()
    
    @Published var feedback = [FeedbackData()]
    @Published var session = SessionDisplayData()
    
    ///State Full Feedback visibility
    @Published var showAllFeedback = false
    ///Define intensity in percent
    @Published var intensity = 0
    
    ///Define if on load data
    @Published var isRedacting = false
    
    ///Define if result avaiable
    @Published var isResultExist = false
    
    func refreshDisplayData(){
        objectWillChange.send()
    }
    
    func loadBuffer(coachId: String,session:SessionDisplayData, completion:@escaping()->Void){
        isRedacting = true
        
        session.coachName = ""
        feedback.removeAll()
        
        group.enter()
        uapi.GetUserData(userId: coachId){ res in
            switch res{
            case .failure(_):
                print(">> Retrieving Coach data failed")
            case .success(let data):
                self.session.coachName = "Coach \(data.Username)"
            }
//            print(">> SessionDetailViewModel: loadBuffer: Leaving: Get User Data")
            self.group.leave()
        }
        
        group.enter()
        sapi.getSessionFeedback(sessionId: session.id){res in
            switch res{
            case .failure(_):
                print(">> Retrieving Session feedback data failed")
            case .success(let data):
                self.feedback = data
            }
//            print(">> SessionDetailViewModel: loadBuffer: Leaving: Get Session Feedback")
            self.group.leave()
        }
        
        self.group.notify(queue: .main){
            print("\n>> SessionDetailViewModel: LoadBuffer : DONE \n")
            self.refreshDisplayData()
            completion()
        }
    }
    
    func checkResult(data:SessionDisplayData){
        if data.result.distance <= 0{
            isResultExist = false
        }else{
            ///Calculate intensity
            let age = TDate().getUserAge(birth: TDate().stringToDate(date: SharedUser.shared.UserData.Birthday))
            intensity = Int(data.result.avgBPM / Double(220-age) * Double(100))
        }
    }
    
    func pushFeedback(ownId:String, input:String) async{
        await withCheckedContinuation{ push in
            let f = FeedbackData()
            f.SenderId = ownId
            f.SessionId = session.id
            f.Content = input
            f.SentDate = TDate().dateToString(date: Date.now,format: "YYYY/MM/dd HH:mm:ss")
            f.Status = 0
            
            sapi.postSessionFeedback(body: f){success in
                if success{
                    self.feedback.append(f)
                }
                else{
                    print(">> Post Feedback Failed")
                }
                
                push.resume()
            }
        }
    }
}
