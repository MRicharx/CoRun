//
//  CSessionCardViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 20/04/23.
//

import Foundation

class CSessionCardViewModel:ObservableObject{
    func getTargetString(target:[TargetDisplayData])->String{
        var result = ""
        for data in target{
            switch data.type.enume{
            case .free:
                return "Free Run"
            case .duration:
                result += "\(data.amount/60) min  \u{2022} "
            case .distance:
                result += "\(data.amount/1000) km  \u{2022} "
            case .pace:
                result += ""
            case .intensity:
                if data.amount<55{
                    result += "Easy Run"
                }
                else if data.amount<65{
                    result += "Medium Run"
                }
                else{
                    result += "Hard Run"
                }
                result += " \u{2022} "
            }
        }
        let final = result.dropLast(3)
        return String(final)
    }
}
