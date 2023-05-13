//
//  CTraineeCard.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct CTraineeCard: View {
    @EnvironmentObject var pvm: TraineeListViewModel
    @EnvironmentObject var own: ProfileData
    
    ///Define to display card as request or default
    @ObservedObject var traineeData : TraineeDisplayData
    
    @State var isAccepting = false
    @State var isDeclining = false
    
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
                        //MARK: Trigger Decline Function
                        if !isDeclining{
                            isDeclining = true
                        }
                    }label: {
                        if isDeclining{
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        else{
                            Image(systemName: "xmark")
                                .modifier(MFont.Headline(size:18))
                                .modifier(MColor.Base())
                        }
                    }.buttonStyle(MButton.SquareButton(isActive: true,color: MColor.ColorPalette().danger))
                    
                    //MARK: Accept
                    Button{
                        //MARK: Trigger Accept Function
                        if !isAccepting{
                            isAccepting = true
                        }
                    }label: {
                        if isAccepting{
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                        else{
                            Image(systemName: "checkmark")
                                .modifier(MFont.Headline(size:18))
                        }
                    }.buttonStyle(MButton.SquareButton(isActive: true))
                }
            }
        }
        .onChange(of: isAccepting){ acc in
            if acc{
                Task{
                    await pvm.acceptReq(traineeId: traineeData.id,ownId:own.UserId)
                    await pvm.loadBuffer(userId: own.UserId)
                    
                    isAccepting = false
                    pvm.refreshDisplayData()
                }
            }
        }
        .onChange(of: isDeclining){ dec in
            if dec{
                Task{
                    await pvm.declineReq(traineeId: traineeData.id,ownId:own.UserId)
                    await pvm.loadBuffer(userId: own.UserId)
                    
                    isDeclining = false
                    
                    pvm.refreshDisplayData()
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
