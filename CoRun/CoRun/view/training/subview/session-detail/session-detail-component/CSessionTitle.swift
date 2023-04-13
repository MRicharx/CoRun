//
//  CSessionTitle.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionTitle: View {
    ///Define session status
    ///1 - Goal not reached,
    ///2 - Some Goal reached,
    ///3 - All goal reached,
    ///else - Activity yet to be done
    @StateObject var status = CompletionStatus()
    
    ///Define session name
    @State var name:String = "NaN"
    ///Define session date
    @State var date:String = "NaN"
    ///Define session time done
    @State var time:String = "dd:MMMM:YYYY"
    ///Define session creator
    @State var creator:String = "NaN"
    
    
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Text(name)
                    .modifier(MFont.Headline(size:24))
                    .modifier(MColor.Text())
                Group{
                    Text(time)
                        .modifier(MFont.Headline(size:14))
                    Text("by "+creator)
                        .modifier(MFont.Body(size:12))
                }.modifier(MColor.DisabledText())
            }.modifier(MView.FillToLeftFrame())
            
            HStack{
                switch status.enume{
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

struct CSessionTitle_Previews: PreviewProvider {
    static var previews: some View {
        CSessionTitle()
    }
}
