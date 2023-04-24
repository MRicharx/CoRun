//
//  CDashboardViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 24/04/23.
//

import Foundation

class CDashboardViewModel:ObservableObject{
    @Published var dashboardDD = DashboardDisplayData()
    
    func loadData(){
        generateDummy()
    }
    
    private func generateDummy(){
        let temp = DashboardDisplayData()
        temp.title = "Berlari-lari"
        temp.targetDistance = "10"
        temp.targetPaceMin = "3"
        temp.targetPaceSec = "20"
        temp.targetIntensity = "70"
        temp.targetDurationHour = "1"
        temp.targetDurationMin = "20"
        temp.desc = "Lari sepuasnya"
        
        dashboardDD = temp
    }
}
