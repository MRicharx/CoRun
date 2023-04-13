//
//  CChat.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI

struct CChatView: View {
    ///Define display option
    @State var displayOption:chatDisplayOption
    enum chatDisplayOption{
        case widget
        case full
    }
    ///Define user data
    let myName = "Me"
    ///Define opponent data
    let oppName = "CoachBudi"
    ///Define Chat conversation
    @State var messageList = ["Selamat Pagi","Selamat Pagi Juga","Lari lagi hari ini","Bagus-bagus, masih aman kah?","Aman gan, cuma agak linu-linu beberapa hari terakhir, agak maksa buat lari yang tempo hari lalu"]
    @State var messageDate = ["1 March - 12.37","1 March - 12.39","1 March - 12.40","1 March - 12.50","1 March - 13.00"]
    @State var messageSender = ["Me","Coach Budi","Me","Me","Coach Budi"]
    
    var body: some View {
        switch(displayOption){
        case .widget:
            VStack(spacing:24){
                //MARK: Message List
                VStack(spacing:12){
                    ForEach(messageList.indices){i in
                        if(i>=messageList.count-3){
                            if(messageSender[i]=="Me"){
                                CChatBubble(sender: messageSender[i], time: messageDate[i], message: messageList[i], style: .home)
                            }
                            else{
                                CChatBubble(sender: messageSender[i], time: messageDate[i], message: messageList[i], style: .away)
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
                        VStack(spacing:12){
                            Spacer()
                            ForEach(messageList.indices){i in
                                if(messageSender[i]=="Me"){
                                    CChatBubble(sender: messageSender[i], time: messageDate[i], message: messageList[i], style: .home)
                                }
                                else{
                                    CChatBubble(sender: messageSender[i], time: messageDate[i], message: messageList[i], style: .away)
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

struct CChatView_Previews: PreviewProvider {
    static var previews: some View {
        CChatView(displayOption: .full)
    }
}
