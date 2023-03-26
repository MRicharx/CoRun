//
//  CSessionGoal.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionGoal: View {
    //TODO: Handling vary goal number
    ///Define session goal
    @State var goal: [String] = ["NaN","NaN","NaN"]
    ///Define session result
    @State var result:[String] = ["-","-","-"]
    
    var body: some View {
        VStack(spacing: 8){
            HStack{
                //MARK: Distance
                VStack(spacing: 2){
                    HStack(alignment:.firstTextBaseline ,spacing:0){
                        Text(result[0])
                            .modifier(MFont.Title2())
                        Text("/\(goal[0]) kM")
                            .modifier(MFont.Headline())
                    }
                    Text("Distance")
                        .modifier(MFont.SubBody())
                        .modifier(MColor.DisabledText())
                }
                .modifier(MView.FillFrame())
                
                CDivider(isHorizontal: false, weight:2,color: MColor.ColorPalette().primaryDisabled)
                    .frame(maxHeight:96)
                
                //MARK: Intensity
                VStack(spacing: 2){
                    HStack(alignment:.firstTextBaseline ,spacing:0){
                        Text(result[1])
                            .modifier(MFont.Title2())
                        Text("/\(goal[1])%")
                            .modifier(MFont.Headline())
                    }
                    Text("Avg. Intensity")
                        .modifier(MFont.SubBody())
                        .modifier(MColor.DisabledText())
                }
                .modifier(MView.FillFrame())
            }
            
            CDivider(isHorizontal: true, weight:2,color: MColor.ColorPalette().primaryDisabled)
            
            //MARK: Pace
            VStack(spacing: 2){
                HStack(alignment:.firstTextBaseline ,spacing:0){
                    Text(result[2])
                        .modifier(MFont.Title2())
                    Text("/\(goal[2])")
                        .modifier(MFont.Headline())
                }
                Text("Pace")
                    .modifier(MFont.SubBody())
                    .modifier(MColor.DisabledText())
            }
        }
        .padding(18)
        .modifier(MView.Card())
    }
}

struct CSessionGoal_Previews: PreviewProvider {
    static var previews: some View {
        CSessionGoal()
    }
}
