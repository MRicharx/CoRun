//
//  CSessionCard.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionCard: View {
    @ObservedObject var data = SessionDisplayData()
    @StateObject var vm = CSessionCardViewModel()
    
    var body: some View {
        HStack(spacing: 18){
            //MARK: Icon
            Group{
                switch(data.status.enume){
                case .planNotReachGoal:
                    Image(systemName: "xmark.seal.fill")
                        .modifier(MColor.Danger())
                case .planPartlyReachGoal:
                    Image(systemName: "checkmark.seal.fill")
                        .modifier(MColor.Alert())
                case .planReachAllGoal:
                    Image(systemName: "checkmark.seal.fill")
                        .modifier(MColor.Primary())
                case .planNotDone:
                    Image(systemName: "seal.fill")
                        .modifier(MColor.DisabledText())
                }
            }.modifier(MFont.Title2())
            
            //MARK: Session description
            VStack(alignment:.leading,spacing:4){
                Text(TDate().dateToString(date: data.date,format:"dd MMMM YYYY"))
                    .modifier(MFont.Headline(size: 14))
                    .modifier(MColor.DisabledText())
                
                if data.id.isEmpty{
                    Text("No Session")
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.DisabledText())
                }else{
                    Text(data.activityName)
                        .modifier(MFont.Headline(size:18))
                        .modifier(MColor.Text())
                    
                    Text(vm.getTargetString(target: data.target))
                        .lineLimit(1)
                        .modifier(MFont.SubBody(size:14))
                        .modifier(MColor.DisabledText())
                }
            }.modifier(MView.FillToLeftFrame())
        }
    }
}

//struct CSessionCard_Previews: PreviewProvider {
//    static var previews: some View {
////        CSessionCard(target: [["Target Distance","10 kM"],["Target Pace","6\'0\""],["Target Intensity","70%"]])
//        CSessionCard()
//    }
//}
