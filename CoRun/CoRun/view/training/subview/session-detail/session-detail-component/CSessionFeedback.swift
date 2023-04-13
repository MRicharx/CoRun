//
//  CSessionFeedback.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CSessionFeedback: View {
    @Binding var showAll:Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18){
            HStack(alignment:.firstTextBaseline){
                Text("Result")
                    .modifier(MFont.Headline(size: 18))
                    .modifier(MColor.DisabledText())
                    .modifier(MView.FillToLeftFrame())
                
                Text("Show All")
                    .modifier(MFont.Headline(size: 14))
                    .modifier(MColor.Primary())
                    .onTapGesture {
                        withAnimation{
                            showAll.toggle()
                        }
                    }
            }
            
            CDivider(weight: 1, cornerRadius: 1)
            
            //MARK: Chat
            CChatView(displayOption: .widget)
        }
        .padding(24)
        .modifier(MView.FillToLeftFrame())
        .modifier(MView.Card())
    }
}

//struct CSessionFeedback_Previews: PreviewProvider {
//    static var previews: some View {
//        CSessionFeedback()
//    }
//}
