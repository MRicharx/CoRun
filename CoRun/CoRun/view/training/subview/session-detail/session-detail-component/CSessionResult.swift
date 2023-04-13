//
//  CSessionResult.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionResult: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            Text("Result")
                .modifier(MFont.Headline(size: 18))
                .modifier(MColor.DisabledText())
            
            VStack(spacing: 12){
                //MARK: Duration
                VStack(alignment:.leading){
                    Text("1:20:58")
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                    Text("Duration")
                        .modifier(MFont.SubBody())
                        .modifier(MColor.DisabledText())
                }.modifier(MView.FillToLeftFrame())
                
                CDivider(weight:2,color: MColor.ColorPalette().primaryDisabled)
                
                HStack{
                    //MARK: Distance
                    VStack(alignment:.leading){
                        Text("10 kM")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Distance")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                    
                    //MARK: Elevation
                    VStack(alignment:.leading){
                        Text("100 M")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Distance")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                }
                
                CDivider(weight:2,color: MColor.ColorPalette().primaryDisabled)
                
                HStack{
                    //MARK: Avg BPM
                    VStack(alignment:.leading){
                        Text("160")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Avg. BPM")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                    
                    //MARK: Intensity
                    VStack(alignment:.leading){
                        Text("70 %")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Avg. Intensity")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                }
                
                CDivider(weight:2,color: MColor.ColorPalette().primaryDisabled)
                
                HStack{
                    //MARK: VO2Max
                    VStack(alignment:.leading){
                        Text("30")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("VO2 Max")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                    
                    //MARK: Vertical Oscillation
                    VStack(alignment:.leading){
                        Text("60 cM")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Vertical Oscillation")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                }
                
                CDivider(weight:2,color: MColor.ColorPalette().primaryDisabled)
                
                HStack{
                    //MARK: Stride
                    VStack(alignment:.leading){
                        Text("60 cM")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Stride")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                    
                    //MARK: Ground Time
                    VStack(alignment:.leading){
                        Text("10 ms")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Ground Time")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillToLeftFrame())
                }
            }
        }
        .padding(24)
        .modifier(MView.FillToLeftFrame())
        .modifier(MView.Card())
    }
}

struct CSessionResult_Previews: PreviewProvider {
    static var previews: some View {
        CSessionResult()
    }
}
