//
//  TraineeViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import Foundation

class TraineeViewModel:ObservableObject{
    @Published var traineeData = ProfileDisplayData()
    @Published var selectedTab = "Calendar"
    
    func loadData(){
        
        generateDummy()
    }
    
    private func generateDummy(){
        traineeData.username = "Budi"
    }
}
