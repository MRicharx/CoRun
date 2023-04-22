//
//  CTraineeCard.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct CTraineeCard: View {
    ///Define to display card as request or default
    @ObservedObject var traineeData : TraineeDisplayData
    
    var body: some View {
        HStack(spacing: 24){
            VStack(alignment:.leading,spacing:2){
                Text(traineeData.username)
                    .modifier(MFont.Headline())
                    .modifier(MColor.Text())
                Text("\(traineeData.gender) - \(TDate().getUserAge(birth: traineeData.birthday)) y/o")
                    .modifier(MFont.Headline(size:16))
                    .modifier(MColor.DisabledText())
            }
            .modifier(MView.FillToLeftFrame())
            
            //MARK: Show Request Response Option
            if(traineeData.isRequest)
            {
                HStack(spacing:12){
                    //MARK: Decline
                    Button{
                        //TODO: Decline Function
                    }label: {
                        Image(systemName: "xmark")
                            .modifier(MFont.Headline(size:18))
                            .modifier(MColor.Base())
                    }.buttonStyle(MButton.SquareButton(isActive: true,color: MColor.ColorPalette().danger))
                    
                    //MARK: Accept
                    Button{
                        //TODO: Accept Function
                    }label: {
                        Image(systemName: "checkmark")
                            .modifier(MFont.Headline(size:18))
                    }.buttonStyle(MButton.SquareButton(isActive: true))
                }
            }
        }
    }
}

//struct CTraineeCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CTraineeCard(isRequest: false)
//        CTraineeCard(isRequest: true)
//    }
//}
