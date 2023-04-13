//
//  CSessionGoal.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionGoal: View {
    ///Define session goal
    @State var goal: [String] = ["NaN","NaN","NaN"]
    ///Define session result
    @State var result:[String] = ["-","-","-"]
    ///Define activity status
    @State var status = [CompletionStatus(),CompletionStatus(),CompletionStatus()]
    ///Define session description
    @State var desc = "Lorem ipsum"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            Text("Run Goal")
                .modifier(MFont.Headline(size: 18))
                .modifier(MColor.DisabledText())
            
            //MARK: Goal List
            VStack(spacing: 12){
                ForEach(goal, id:\.self){ data in
                    HStack(spacing: 12){
                        Group{
                            Image(systemName: "circle.fill")
                            Text(data)
                            
                            Text("Status")
                        }.modifier(MFont.Body(size: 20))
                    }
                }
            }
            
            VStack(alignment: .leading, spacing:8){
                Text("Desc")
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
                Text(desc)
                    .modifier(MFont.Body(size: 18))
                    .modifier(MColor.Text())
            }
        }
        .padding(24)
        .modifier(MView.FillToLeftFrame())
        .modifier(MView.Card())
    }
}

struct CSessionGoal_Previews: PreviewProvider {
    static var previews: some View {
        CSessionGoal()
    }
}
