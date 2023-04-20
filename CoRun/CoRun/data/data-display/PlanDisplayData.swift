//
//  PlanDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 20/04/23.
//

import Foundation

class PlanDisplayData:ObservableObject{
    ///Define list of session for this week
    var session:[SessionDisplayData]
    
    init(){
        session = [SessionDisplayData()]
    }
    init(session: [SessionDisplayData]) {
        self.session = session
    }
}
