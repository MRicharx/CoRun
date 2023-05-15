//
//  TraineeSummaryViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 22/04/23.
//

import Foundation

class TraineeSummaryViewModel:SummaryViewModel{
    @Published var isAccepting = false
    @Published var isDeclining = false
    @Published var isDismissing = false
    
    @Published var showDismissAlert = false
    
    func countBMI(height:Int, weight:Int)->Int{
        return weight / (height*height)
    }
}
