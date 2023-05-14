//
//  CSessionTitle.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionTitle: View {
    @ObservedObject var data:SessionDisplayData
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(data.activityName)
                    .modifier(MFont.Headline(size:24))
                    .modifier(MColor.Text())
                Group{
                    Text(TDate().dateToString(date: data.date, format: "dd MMMM YYYY"))
                        .modifier(MFont.Headline(size:14))
                    Text("by "+data.coachName)
                        .modifier(MFont.Body(size:12))
                        .redacted(reason: data.coachName == "Coach --" ? .placeholder: [])
                }.modifier(MColor.DisabledText())
            }.modifier(MView.FillToLeftFrame())
            
            HStack{
                switch data.status.enume{
                case .planNotReachGoal:
                    Group{
                        Text("Goal Not Reached")
                        Image(systemName: "xmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Danger())
                case .planNotDone:
                    Group{
                        Text("Not Completed")
                        Image(systemName: "xmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
                case .planPartlyReachGoal:
                    Group{
                        Text("Partly Completed")
                        Image(systemName: "checkmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Alert())
                case .planReachAllGoal:
                    Group{
                        Text("Completed")
                        Image(systemName: "checkmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Primary())
                }
            }
            .modifier(MView.FillToRightFrame())
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 18, trailing: 24))
        .modifier(MView.Card())
    }
}
//
//struct CSessionTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        CSessionTitle()
//    }
//}
