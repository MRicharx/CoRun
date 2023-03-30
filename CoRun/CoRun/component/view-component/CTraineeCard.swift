//
//  CTraineeCard.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct CTraineeCard: View {
    ///Define to display card as request or default
    @State var isRequest = false
    
    var body: some View {
        VStack(alignment:.leading,spacing: 18){
            VStack(alignment:.leading,spacing:2){
                Text("Name")
                    .modifier(MFont.Headline())
                    .modifier(MColor.Text())
                Text("Gender - Age y/o")
                    .modifier(MFont.Headline(size:16))
                    .modifier(MColor.DisabledText())
            }
            .modifier(MView.FillToLeftFrame())
            
            //MARK: Show Request Response Option
            if(isRequest)
            {
                HStack(spacing: 18){
                    //MARK: Decline
                    Button{
                        //TODO: Decline Function
                    }label: {
                        Text("Decline")
                            .modifier(MFont.Headline(size:18))
                    }.buttonStyle(MButton.DangerButton(isActive: true,invert: true,padding: 8))
                    
                    //MARK: Accept
                    Button{
                        //TODO: Accept Function
                    }label:{
                        //MARK: Decline
                        Button{
                            //TODO: Decline Function
                        }label: {
                            Text("Accept")
                                .modifier(MFont.Headline(size:18))
                        }.buttonStyle(MButton.DefaultButton(isActive: true,padding: 8))
                    }
                }
            }
        }
        .padding(18)
        .modifier(MView.Card())
    }
}

struct CTraineeCard_Previews: PreviewProvider {
    static var previews: some View {
        CTraineeCard()
    }
}
