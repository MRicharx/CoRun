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
    @State var status:Int = 0
    
    ///Define session name
    @State var name:String = "NaN"
    ///Define session date
    @State var date:String = "NaN"
    ///Define session time done
    @State var time:String = "--:--:--"
    ///Define session creator
    @State var creator:String = "NaN"
    
    
    
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                Group{
                    HStack{
                        Text(name)
                            .modifier(MFont.Headline(size:16))
                        Text("- "+date)
                            .modifier(MFont.Body(size:16))
                    }
                    Text(time)
                        .modifier(MFont.Headline(size:14))
                    Text("by "+creator)
                        .modifier(MFont.Body(size:14))
                }.modifier(MColor.DisabledText())
            }.modifier(MView.FillToLeftFrame())
            
            HStack{
                switch status{
                case 1:
                    Group{
                        Text("Not Completed")
                        Image(systemName: "xmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Danger())
                case 2:
                    Group{
                        Text("Partly Completed")
                        Image(systemName: "checkmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Alert())
                case 3:
                    Group{
                        Text("Completed")
                        Image(systemName: "checkmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Primary())
                default:
                    Group{
                        Text("Not Completed")
                        Image(systemName: "seal.fill")
                    }
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.Shade())
                }
            }
            .modifier(MView.FillToRightFrame())
        }
        .padding(EdgeInsets(top: 14, leading: 18, bottom: 14, trailing: 18))
        .modifier(MView.Card())
    }
}

struct CSessionTitle_Previews: PreviewProvider {
    static var previews: some View {
        CSessionTitle()
    }
}
