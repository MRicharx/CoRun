//
//  CChat.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI

struct CChatView: View {
    @EnvironmentObject var own: ProfileData
    @EnvironmentObject var pvm: SessionDetailViewModel
    
    @State var displayOption:chatDisplayOption
    enum chatDisplayOption{
        case widget
        case full
    }
    ///Define user data
    private let myName = "Me"
    
    var body: some View {
        switch(displayOption){
        case .widget:
            VStack(spacing:24){
                //MARK: Message List
                VStack(spacing:12){
                    if pvm.feedback.count<=0{
                        Text("No Feedback Available")
                            .modifier(MFont.Caption1(isItalic:true))
                            .modifier(MColor.DisabledText())
                    }
                    else{
                        ForEach(pvm.feedback.indices, id:\.self){ i in
                            if(pvm.feedback.count>3 && i<pvm.feedback.count-3){
                                
                            }
                            else if(pvm.feedback[i].SenderId == own.UserId){
                                CChatBubble(sender: myName, time: pvm.feedback[i].SentDate, message: pvm.feedback[i].Content, style: .home)
                            }
                            else{
                                CChatBubble(sender: pvm.session.coachName, time: pvm.feedback[i].SentDate, message: pvm.feedback[i].Content, style: .away)
                            }
                           
                        }
                    }
                }
                
                //MARK: Send Bar
                CChatSendBar()
            }
        case .full:
            VStack(spacing: 0){
                //MARK: Message List
                ///Set content to bottom up orientation
                GeometryReader{ proxy in
                    ScrollView{
                        VStack(alignment:.center, spacing:12){
                            if pvm.feedback.count<=0{
                                Text("No Feedback Available")
                                    .modifier(MFont.Caption1(isItalic:true))
                                    .modifier(MColor.DisabledText())
                                    .modifier(MView.FillFrame())
                            }
                            else{
                                ForEach(pvm.feedback.indices, id: \.self){ i in
                                    if(pvm.feedback[i].SenderId == own.UserId){
                                        CChatBubble(sender: myName, time: pvm.feedback[i].SentDate, message: pvm.feedback[i].Content, style: .home)
                                    }
                                    else{
                                        CChatBubble(sender: pvm.session.coachName, time: pvm.feedback[i].SentDate, message: pvm.feedback[i].Content, style: .away)
                                    }
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 24, bottom: 18, trailing: 24))
                        .frame(minHeight: proxy.size.height)
                    }
                }
                
                
                //MARK: Send Bar
                VStack{
                    CChatSendBar()
                }
                .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
                .modifier(MView.Card())
            }
        }
    }
}

//struct CChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        CChatView(displayOption: .full)
//    }
//}
