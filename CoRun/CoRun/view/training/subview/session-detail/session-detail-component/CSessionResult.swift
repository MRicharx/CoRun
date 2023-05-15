//
//  CSessionResult.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionResult: View {
    @ObservedObject var vm:SessionDetailViewModel
    @ObservedObject var data : SessionDisplayData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            if data.status.enume == .planNotDone{
                Text("No Result Available")
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
            }
            else{
                Text("Result")
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
                VStack(spacing: 12){
                    //MARK: Duration
                    VStack(alignment:.leading){
                        Text(TDate().getStringinHMS(seconds: data.result.duration))
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
                            Text("\(data.result.distance/1000, specifier: "%.2f") km")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Distance")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Elevation
                        VStack(alignment:.leading){
                            Text("\(data.result.elevGain, specifier: "%.2f") m")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Elevation Gain")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                    }
                    
                    CDivider(weight:2,color: MColor.ColorPalette().primaryDisabled)
                    
                    HStack{
                        //MARK: Avg BPM
                        VStack(alignment:.leading){
                            Text(String(data.result.avgBPM))
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Avg. BPM")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Intensity
                        VStack(alignment:.leading){
                            Text("\(vm.intensity) %")
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
                            Text("\(data.result.vo2M , specifier: "%.1f")")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("VO2 Max")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Vertical Oscillation
                        VStack(alignment:.leading){
                            Text("\(data.result.verticalOsc , specifier: "%.1f") cM")
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
                            Text("\(data.result.stride, specifier: "%.1f") cM")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Stride")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Ground Time
                        VStack(alignment:.leading){
                            Text("\(data.result.groundTime, specifier: "%.1f") ms")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Ground Time")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                    }
                }
            }
        }
        .padding(24)
        .modifier(MView.FillToLeftFrame())
        .modifier(MView.Card())
    }
}

//struct CSessionResult_Previews: PreviewProvider {
//    static var previews: some View {
//        CSessionResult()
//    }
//}
