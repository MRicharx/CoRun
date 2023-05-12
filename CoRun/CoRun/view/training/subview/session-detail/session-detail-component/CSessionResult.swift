//
//  CSessionResult.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionResult: View {
    @ObservedObject var vm:SessionDetailViewModel
    @ObservedObject var result : ResultDisplayData
    
    @State var noResult = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            if noResult{
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
                        Text(TDate().getStringinHMS(seconds: TDate().getSecondBetweenDate(start: result.start, end: result.end)))
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
                            Text("\(result.distance, specifier: "%.2f") km")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Distance")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Elevation
                        VStack(alignment:.leading){
                            Text("\(result.elevGain, specifier: "%.2f") m")
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
                            Text(String(result.avgBPM))
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
                            Text("\(result.vo2M , specifier: "%.1f")")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("VO2 Max")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Vertical Oscillation
                        VStack(alignment:.leading){
                            Text("\(result.verticalOsc , specifier: "%.1f") cM")
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
                            Text("\(result.stride, specifier: "%.1f") cM")
                                .modifier(MFont.Headline())
                                .modifier(MColor.Text())
                            Text("Stride")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }.modifier(MView.FillToLeftFrame())
                        
                        //MARK: Ground Time
                        VStack(alignment:.leading){
                            Text("\(result.groundTime, specifier: "%.1f") ms")
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
        .onAppear{
            if result.distance <= 0{
                noResult = true
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
