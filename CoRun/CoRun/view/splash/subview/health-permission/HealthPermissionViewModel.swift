//
//  HealthPermissionViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/03/23.
//

import Foundation

class HealthPermissionViewModel:SplashViewModel{
    @Published var hk = HHealth()
    
    ///Define if asking permission success
    @Published var askDone = false
    
    override init() {
        super.init()
        isLoading = false
    }
    
    func requestHealthPermission(){
        isLoading = true
        
        //TODO: Test this function
        hk.requestPermission{isAsked in
            if isAsked{
                self.askDone = true
                SharedHealthPermission.shared.ishealthPermissionAsked = "asked"
            }
            else{
                self.askDone = false
            }
            
            self.isLoading = false
        }
    }
}
