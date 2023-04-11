//
//  CSessionCard.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionCard: View {
    ///Define completion status
    @StateObject var status:CompletionStatus = CompletionStatus()
    ///Define time when activity need to be done value
    @State var time:String = "NaN"
    ///Define activity tyoe name value
    @State var activityName:String = "NaN"
    
    ///Define target list and value
    let target:[[String]] = [[String]]()
    
    ///Define printed target
    @State var activityTarget = "NaN"
    
    var body: some View {
        HStack(spacing: 18){
            //MARK: Session Image
           Rectangle()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 72)
            
            //MARK: Session description
            VStack(alignment:.leading){
                Text(time)
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
                
                Text(activityName)
                    .modifier(MFont.Headline())
                    .modifier(MColor.Text())
                
                Text(activityTarget)
                    .modifier(MFont.SubBody())
                    .modifier(MColor.DisabledText())
            }.modifier(MView.FillToLeftFrame())
            
            //MARK: Icon
            Group{
                switch(status.enume){
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
            }.modifier(MFont.Title1())
        }
        .onTapGesture {
            status.set(newStatus: .planReachAllGoal)
        }
        
//        VStack{
//            //MARK: Summary
//            HStack{
//                Text(activityName)
//                    .modifier(MFont.Headline())
//                    .modifier(MColor.Text())
//                    .modifier(MView.FillToLeftFrame())
//
//                switch status{
//                case .notDone:
//                    Group{
//                        Text("Goal Not Reached")
//                        Image(systemName: "xmark.seal.fill")
//                    }
//                    .modifier(MFont.Headline(size: 16))
//                    .modifier(MColor.Danger())
//                case .partlyDone:
//                    Group{
//                        Text("Partly Completed")
//                        Image(systemName: "checkmark.seal.fill")
//                    }
//                    .modifier(MFont.Headline(size: 16))
//                    .modifier(MColor.Alert())
//                case .Done:
//                    Group{
//                        Text("Completed")
//                        Image(systemName: "checkmark.seal.fill")
//                    }
//                    .modifier(MFont.Headline(size: 16))
//                    .modifier(MColor.Primary())
//                case .invalid:
//                    Group{
//                        Text(time)
//                        Image(systemName: "seal.fill")
//                    }
//                    .modifier(MFont.Headline(size: 16))
//                    .modifier(MColor.DisabledText())
//                }
//            }
//
//            //MARK: Target List
//            if(target.isEmpty){
//                ///Give Empty View
//            }
//            else{
//                VStack(spacing:6){
//                    ForEach(target, id: \.self){trgt in
//                        HStack{
//                            Group{
//                                Text(trgt[0])
//                                CDivider(weight:1,color: MColor.ColorPalette().base)
//                                Text(trgt[1])
//                            }
//                            .modifier(MFont.Headline(size: 14))
//                            .modifier(MColor.Base())
//                        }
//                    }
//                }
//                .modifier(MView.FillFrame())
//                .modifier(MView.Background(color: MColor.ColorPalette().primary,cornerRadius: 12, padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)))
//            }
//
//        }
//        .padding(18)
    }
}

struct CSessionCard_Previews: PreviewProvider {
    static var previews: some View {
//        CSessionCard(target: [["Target Distance","10 kM"],["Target Pace","6\'0\""],["Target Intensity","70%"]])
        CSessionCard()
    }
}
