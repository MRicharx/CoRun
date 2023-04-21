//
//  GraphDisplayDataList.swift
//  CoRun
//
//  Created by Marselus Richard on 21/04/23.
//

import Foundation

class GraphDisplayDataList:ObservableObject{
    
    @Published var amount = [Double]()
    @Published var label = [String]()
    
    init(){}
    init(amount:[Double],label:[String]){
        self.amount=amount
        self.label=label
    }
    
    func clear(){
        amount.removeAll()
        label.removeAll()
    }
}
