//
//  SessionDetailView.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct SessionDetailView: View {
    var body: some View {
        ScrollView{
            VStack(alignment:.leading,spacing: 24){
                //MARK: Title
                VStack(alignment:.leading,spacing: 12){
                    Text("Session\nDetail")
                        .modifier(MView.safePadding())
                        .modifier(MColor.Text())
                        .modifier(MFont.Title())
                    CSessionTitle()
                }
                
                VStack(alignment:.leading,spacing: 12){
                    Text("Goal")
                        .modifier(MView.safePadding())
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                    CSessionGoal()
                }

                VStack(alignment:.leading,spacing: 12){
                    Text("Feedback")
                        .modifier(MView.safePadding())
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
        //            CSessionFeedback()
                }

                VStack(alignment:.leading,spacing: 12){
                    Text("Run Result")
                        .modifier(MView.safePadding())
                        .modifier(MFont.Headline())
                        .modifier(MColor.Text())
                    CSessionResult()
                }
            }
        }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView()
    }
}
