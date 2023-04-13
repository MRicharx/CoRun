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
                ForEach(messageList.indices){i in
                    VStack(spacing:12){
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
            Text("NaN")
        }
    }
}

struct CChatView_Previews: PreviewProvider {
    static var previews: some View {
        CChatView(displayOption: .widget)
    }
}
