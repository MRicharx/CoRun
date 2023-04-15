//
//  HealthPermissionViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation

class HealthPermissionViewModel:SplashViewModel{
    @Published var hk = HHealth()
    
    override init() {
        
    }
    
    func requestHealthPermission(completion: @escaping ((_ status: Bool) -> Void)){
        toggleLoading()
        
        //TODO: Test this function
        hk.requestPermission{status in
            completion(status)
        }
    }
}
