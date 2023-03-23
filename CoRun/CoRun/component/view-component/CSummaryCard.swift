//
//  CSummaryHead.swift
//  CoRun
//
//  Created by Marselus Richard on 23/03/23.
//

import SwiftUI

struct CSummaryCard: View {
    ///Define distance ran value
    @State var distanceRan: String = "NaN"
    ///Define total run value
    @State var totalRun: String = "NaN"
    ///Define average pace value
    @State var avgPace: String = "NaN"
    ///Define total run time value
    @State var runTime: String = "NaN"
    ///Define average intensity value
    @State var avgIntensity: String = "NaN"
    ///Define average bpm value
    @State var avgBPM: String = "NaN"
    
    var body: some View {
        VStack(spacing: 24){
            //MARK: Distance Ran
            HStack(spacing: 18){
                CDivider(isHorizontal: false,weight: 12, color: MColor.ColorPalette().primary,cornerRadius: 4)
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment:.leading){
                    HStack(alignment:.firstTextBaseline){
                        Group{
                            Text(String(distanceRan))
                                .modifier(MFont.Hero(size:81))
                            Text("kM")
                                .modifier(MFont.Title(isItalic: true, size: 24))
                        }.modifier(MColor.Text())
                    }
                    
                    Text("Distance Ran")
                        .modifier(MFont.Headline())
                        .modifier(MColor.DisabledText())
                }
                .modifier(MView.FillToLeftFrame())
            }
            
            //MARK: Sub data
            VStack(spacing: 24){
                HStack{
                    //MARK: Total Run
                    VStack{
                        Text(String(totalRun))
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Total Run")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                    
                    //MARK: Average Pace
                    VStack{
                        Text(avgPace)
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Avg. Pace")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                    
                    //MARK: Run Time
                    VStack{
                        Text(runTime)
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Run Time")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                }
                HStack{
                    //MARK: Average Intensity
                    VStack{
                        Text(avgIntensity+"%")
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Avg. Intensity")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                    
                    //MARK: Average BPM
                    VStack{
                        Text(avgBPM)
                            .modifier(MFont.Headline())
                            .modifier(MColor.Text())
                        Text("Avg. BPM")
                            .modifier(MFont.SubBody())
                            .modifier(MColor.DisabledText())
                    }.modifier(MView.FillFrame())
                }
            }
        }
        .padding(24)
        .modifier(MView.Card())
    }
}

struct CSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        CSummaryCard()
    }
}
