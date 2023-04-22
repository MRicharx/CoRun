//
//  TargetDisplayData.swift
//  CoRun
//
//  Created by Marselus Richard on 20/04/23.
//

import Foundation

class TargetDisplayData:ObservableObject{
    @Published var type:TargetType
    @Published var amount: Double
    
    init(targetData:SessionTarget){
        type = TargetType(status: targetData.targetType)
        amount = targetData.amount
    }
}