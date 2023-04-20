//
//  SessionDetailViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import Foundation

class SessionDetailViewModel:ObservableObject{
    ///State Full Feedback visibility
    @Published var showAllFeedback = false
    ///Define intensity in percent
    @Published var intensity = 0
    
    ///Define if result avaiable
    @Published var isResultExist = false
    
    func checkResult(data:SessionDisplayData){
        if data.result.distance <= 0{
            isResultExist = false
        }else{
            ///Calculate intensity
            let age = TDate().getUserAge(birth: TDate().stringToDate(date: SharedUser.shared.UserData.dateOfBirth))
            intensity = Int(data.result.avgBPM / Double(220-age) * Double(100))
        }
    }
}
