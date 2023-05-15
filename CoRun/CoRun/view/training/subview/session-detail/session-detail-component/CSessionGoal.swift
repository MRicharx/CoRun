//
//  CSessionGoal.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionGoal: View {
    @ObservedObject var data:SessionDisplayData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            if data.target.count > 0{
                Text("Run Goal")
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
                
                //MARK: Goal List
                VStack(alignment: .leading, spacing: 12){
                    ForEach(data.target.indices, id:\.self){ i in
                        if data.target[i].amount > 0{
                            HStack(spacing: 12){
                                Group{
                                    switch data.target[i].type.enume{
                                    case .free:
                                        Image(systemName: "figure.run")
                                            .modifier(MColor.Primary())
                                        Text("Free Run")
                                    case .distance:
                                        Image(systemName: "ruler.fill")
                                            .modifier(MColor.Primary())
                                        Text("\(data.target[i].amount/1000, specifier: "%.2f") km")
                                    case .pace:
                                        Image(systemName: "bolt.fill")
                                            .modifier(MColor.Primary())
                                        Text(TDate().secondToPace(seconds: data.target[i].amount))
                                    case .duration:
                                        Image(systemName: "clock.fill")
                                            .modifier(MColor.Primary())
                                        Text(TDate().getStringinHMS(seconds: data.target[i].amount))
                                    case .intensity:
                                        Image(systemName: "flame.fill")
                                            .modifier(MColor.Primary())
                                        Text("\(data.target[i].amount, specifier: "%.2f") %")
                                    }
                                }.modifier(MFont.Body(size: 18))
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing:8){
                    Text("Desc")
                        .modifier(MFont.Headline(size: 18))
                        .modifier(MColor.DisabledText())
                    Text(data.desc == "" ? data.desc : "No description")
                        .modifier(MFont.Body(size: 18))
                        .modifier(MColor.Text())
                }
            }
            else{
                Text("Free Run")
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
            }
        }
        .padding(24)
        .modifier(MView.FillToLeftFrame())
        .modifier(MView.Card())
    }
}

//struct CSessionGoal_Previews: PreviewProvider {
//    static var previews: some View {
//        CSessionGoal()
//    }
//}
