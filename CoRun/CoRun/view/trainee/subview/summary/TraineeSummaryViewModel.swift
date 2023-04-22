//
//  TraineeSummaryViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 22/04/23.
//

import Foundation

class TraineeSummaryViewModel:SummaryViewModel{
    @Published var traineeData = ProfileDisplayData()
    
    func countBMI(height:Int, weight:Int)->Int{
        return weight / (height*height)
    }
    
    override func loadData() {
        super.loadData()
    }
    
    override func generateDummy(){
        super.generateDummy()
        
        let temp = ProfileDisplayData()
        temp.id = ""
        temp.username = "Budi"
        temp.birthday = TDate().stringToDate(date: "10/10/2000",format: "dd/MM/YYYY")
        temp.weight = 60
        temp.height = 170
        temp.gender = "Male"
    }
}
