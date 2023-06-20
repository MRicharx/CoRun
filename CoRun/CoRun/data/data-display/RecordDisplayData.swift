//
//  RecordDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 19/06/23.
//

import Foundation

class RecordDisplayData:ObservableObject{
    var id = ""
    @Published var content = ""
    @Published var writer = ""
    @Published var date = Date.now
    
    init(){}
    
    init(data:RecordData){
        id = String(data.recordId)
        content = data.content
        writer = data.writer
        date = TDate().stringToDate(date:data.date)
    }
}
