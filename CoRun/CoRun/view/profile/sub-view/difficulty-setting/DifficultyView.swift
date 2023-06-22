//
//  DifficultyView.swift
//  CoRun
//
//  Created by Marselus Richard on 20/06/23.
//

import SwiftUI

struct DifficultyView: View {
    @StateObject var vm = DifficultyViewModel()
    
    var body: some View {
        VStack(alignment:.leading,spacing: 24){
            Text("Configure Scoring Difficulty")
                .modifier(MFont.Headline())
                .modifier(MColor.Text())
            
            //MARK: Distance
            HStack{
                Text("Distance")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
                    .modifier(MView.FillToLeftFrame())
                HStack{
                    Group{
                        Image(systemName: "chevron.left")
                            .onTapGesture {
                                vm.distanceDif = vm.increase(cur: vm.distanceDif)
                                SharedDifficulty.shared.Distance = vm.distanceDif
                            }
                            .modifier(MColor.Primary())
                        Text(vm.distanceDif)
                            .modifier(MColor.Text())
                        Image(systemName: "chevron.right")
                            .onTapGesture {
                                vm.distanceDif = vm.decrease(cur: vm.distanceDif)
                                SharedDifficulty.shared.Distance = vm.distanceDif
                            }
                            .modifier(MColor.Primary())
                    }.modifier(MFont.Body(size:18))
                }
            }
            
            //MARK: Duration
            HStack{
                Text("Duration")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
                    .modifier(MView.FillToLeftFrame())
                HStack{
                    Group{
                        Image(systemName: "chevron.left")
                            .onTapGesture {
                                vm.durationDif = vm.increase(cur: vm.durationDif)
                                SharedDifficulty.shared.Duration = vm.durationDif
                            }
                            .modifier(MColor.Primary())
                        Text(vm.durationDif)
                            .modifier(MColor.Text())
                        Image(systemName: "chevron.right")
                            .onTapGesture {
                                vm.durationDif = vm.decrease(cur: vm.durationDif)
                                SharedDifficulty.shared.Duration = vm.durationDif
                            }
                            .modifier(MColor.Primary())
                    }.modifier(MFont.Body(size:18))
                }
            }
            
            //MARK: Pace
            HStack{
                Text("Pace")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
                    .modifier(MView.FillToLeftFrame())
                HStack{
                    Group{
                        Image(systemName: "chevron.left")
                            .onTapGesture {
                                vm.paceDif = vm.increase(cur: vm.paceDif)
                                SharedDifficulty.shared.Pace = vm.paceDif
                            }
                            .modifier(MColor.Primary())
                        Text(vm.paceDif)
                            .modifier(MColor.Text())
                        Image(systemName: "chevron.right")
                            .onTapGesture {
                                vm.paceDif = vm.decrease(cur: vm.paceDif)
                                SharedDifficulty.shared.Pace = vm.paceDif
                            }
                            .modifier(MColor.Primary())
                    }.modifier(MFont.Body(size:18))
                }
            }
            
            //MARK: Intensity
            HStack{
                Text("Intensity")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
                    .modifier(MView.FillToLeftFrame())
                HStack{
                    Group{
                        Image(systemName: "chevron.left")
                            .onTapGesture {
                                vm.intensityDif = vm.increase(cur: vm.intensityDif)
                                SharedDifficulty.shared.Intensity = vm.intensityDif
                            }
                            .modifier(MColor.Primary())
                        Text(vm.intensityDif)
                            .modifier(MColor.Text())
                        Image(systemName: "chevron.right")
                            .onTapGesture {
                                vm.intensityDif = vm.decrease(cur: vm.intensityDif)
                                SharedDifficulty.shared.Intensity = vm.intensityDif
                            }
                            .modifier(MColor.Primary())
                    }.modifier(MFont.Body(size:18))
                }
            }
            
            Spacer()
        }
        .padding(48)
        .modifier(MView.FillToLeftFrame())
        .onAppear(){
            vm.setup()
        }
    }
}

struct DifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyView()
    }
}
