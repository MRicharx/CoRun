//
//  TraineeDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 21/04/23.
//

import Foundation

class TraineeDisplayData:ObservableObject{
    @Published var id = ""
    @Published var username = ""
    @Published var birthday = Date.now
    @Published var gender = ""
    @Published var height = 0
    @Published var weight = 0
    @Published var isRequest = false
    
    init(){
        
    }
    
}
