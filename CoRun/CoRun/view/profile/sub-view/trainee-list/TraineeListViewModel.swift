//
//  TraineeListViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import Foundation

class TraineeListViewModel:ObservableObject{
    ///Define search value
    @Published var searchInput = ""
    ///Define request section visibility
    @Published var showAllRequest = false
    ///Define list of trainee
    @Published var traineeList = [TraineeDisplayData]()
    ///Define list of request
    @Published var requestList = [TraineeDisplayData]()
 
    func loadData(){
        traineeList.removeAll()
        requestList.removeAll()
        
        generateDummy()
    }
    
    private func generateDummy(){
        for i in 1...3{
            let temp = TraineeDisplayData()
            temp.id = "\(i)r"
            temp.username = "Budi\(i)"
            temp.birthday = TDate().stringToDate(date: "10/March/200\(i)",format: "dd/MMMM/YYYY")
            temp.gender = "Male"
            temp.height = 170+i
            temp.weight = 50+i
            temp.isRequest = true
            
            requestList.append(temp)
        }
        
        for i in 1...8{
            let temp = TraineeDisplayData()
            temp.id = "\(i)r"
            temp.username = "Budi\(i)"
            temp.birthday = TDate().stringToDate(date: "10/March/200\(i)",format: "dd/MMMM/YYYY")
            temp.gender = "Male"
            temp.height = 170+i
            temp.weight = 50+i
            
            traineeList.append(temp)
        }
    }
}
