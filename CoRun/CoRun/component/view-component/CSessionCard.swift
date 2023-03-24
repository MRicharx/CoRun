//
//  CSessionCard.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionCard: View {
    ///Define completion status
    ///1 - Goal not reached,
    ///2 - Some Goal reached,
    ///3 - All goal reached,
    ///else - Activity yet to be done
    @State var status:Int = 3
    ///Define time when activity need to be done value
    @State var time:String = "NaN"
    ///Define activity tyoe name value
    @State var activityName:String = "NaN"
    
    ///Define target list and value
    @State var target:[[String]] = [[String]]()
    
    var body: some View {
        VStack{
            //MARK: Summary
            HStack{
                Text(activityName)
                    .modifier(MFont.Headline())
                    .modifier(MColor.Text())
                    .modifier(MView.FillToLeftFrame())
                
                switch status{
                case 1:
                    Group{
                        Text("Goal Not Reached")
                        Image(systemName: "xmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 16))
                    .modifier(MColor.Danger())
                case 2:
                    Group{
                        Text("Partly Completed")
                        Image(systemName: "checkmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 16))
                    .modifier(MColor.Alert())
                case 3:
                    Group{
                        Text("Completed")
                        Image(systemName: "checkmark.seal.fill")
                    }
                    .modifier(MFont.Headline(size: 16))
                    .modifier(MColor.Primary())
                default:
                    Group{
                        Text(time)
                        Image(systemName: "seal.fill")
                    }
                    .modifier(MFont.Headline(size: 16))
                    .modifier(MColor.DisabledText())
                }
            }
            
            //MARK: Target List
            if(target.isEmpty){
                ///Give Empty View
            }
            else{
                VStack(spacing:6){
                    ForEach(target, id: \.self){trgt in
                        HStack{
                            Group{
                                Text(trgt[0])
                                CDivider(weight:1,color: MColor.ColorPalette().base)
                                Text(trgt[1])
                            }
                            .modifier(MFont.Headline(size: 14))
                            .modifier(MColor.Base())
                        }
                    }
                }
                .modifier(MView.FillFrame())
                .modifier(MView.Background(color: MColor.ColorPalette().primary,cornerRadius: 12, padding: EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)))
            }
            
        }
        .padding(18)
        .modifier(MView.Card(cornerRadius:24))
    }
}

struct CSessionCard_Previews: PreviewProvider {
    static var previews: some View {
//        CSessionCard(target: [["Target Distance","10 kM"],["Target Pace","6\'0\""],["Target Intensity","70%"]])
        CSessionCard()
    }
}
