//
//  TrainingViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 16/04/23.
//

import Foundation

class TrainingViewModel:ObservableObject{
    @Published var sessionList = [SessionData()]
//    @Published var displayData:
    
    init(){
        sessionList.removeAll()
    }
    init(session: [SessionData]){
        sessionList = session
    }
    
    ///To refresh displayed data
    func refresh(){
        
    }
}
