//
//  CActivityCard.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CActivityCard: View {
    ///Define completion status
    @State var status:Int = 0
    ///Define activity date value
    @State var date:String = "NaN"
    ///Define activity distance value
    @State var distance:String = "NaN"
    ///Define time when activity is done value
    @State var time:String = "NaN"
    ///Define activity tyoe name value
    @State var activityName:String = "NaN"
    
    
    var body: some View {
        HStack(spacing: 24){
            ///Check completion status
            ///1 - Goal not reached
            ///2 - Some Goal reached
            ///3 - All goal reached
            ///else - Activity yet to be done
            Group{
                switch status{
                case 1:
                    Image(systemName: "xmark.seal.fill")
                        .modifier(MColor.Danger())
                case 2:
                    Image(systemName: "checkmark.seal.fill")
                        .modifier(MColor.Alert())
                case 3:
                    Image(systemName: "checkmark.seal.fill")
                        .modifier(MColor.Primary())
                default:
                    Image(systemName: "seal.fill")
                        .modifier(MColor.DisabledText())
                }
            }.modifier(MFont.Title2())
            
            VStack(alignment:.leading){
                Text(date)
                    .modifier(MFont.Headline())
                    .modifier(MColor.Text())
                Text(time+" - "+activityName)
                    .modifier(MFont.SubBody())
                    .modifier(MColor.DisabledText())
            }.modifier(MView.FillToLeftFrame())
            
            Text(distance+" kM")
                .modifier(MFont.Headline())
                .modifier(MColor.Text())
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        .modifier(MView.Card(cornerRadius: 12))
    }
}

struct CActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        CActivityCard()
    }
}
