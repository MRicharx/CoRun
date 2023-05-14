//
//  TraineeCalendarViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 22/04/23.
//

import Foundation
import SwiftUI

class TraineeCalendarViewModel:CalendarViewModel{
    private let sapi = SessionAPI()
    private let tapi = TraineeAPI()
    
    let today = TDate().getStartDate()
    
    ///Define if session data is under going change
    @Published var isPostingSession = false
    @Published var isDeletingSession = false
    
    ///Define if session data need update
    @Published var updateSession = false
    
    func refreshDisplayData(){
        findSession(byDate: selectedDate)
        isLoaded = true
        objectWillChange.send()
    }
    
    func postSession(data:SessionData) async{
        await withCheckedContinuation{ posting in
            tapi.postTraineeSession(body: data){ success in
                if !success{
                    print(">> DashboardViewModel: Posting Session Failed")
                }
                else{
                    print(">> DashboardViewModel: Posting Session Success")
                }
                posting.resume()
            }
        }
        
    }
    
    func deleteSession(sessionId:Int) async{
        await withCheckedContinuation{discarding in
            tapi.deleteTraineeSession(sessionId: sessionId){success in
                if !success{
                    print(">> DashboardViewModel: Deleting Session Failed")
                }
                discarding.resume()
            }
        }
    }
}
