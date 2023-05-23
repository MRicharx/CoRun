//
//  CChatBubble.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI

struct CChatBubble: View {
    ///Define sender
    @State var sender:String
    ///Define sent date
    @State var time:String
    ///Define message content
    @State var message:String
    
    ///Define bubble style
    @State var style:bubbleStyleOption
    enum bubbleStyleOption{
        case home
        case away
    }
    
    var body: some View {
        Group{
            switch(style){
            case .home:
                VStack(alignment:.trailing,spacing:4){
                    HStack{
                        Text(time)
                            .modifier(MFont.Body(size: 16))
                            .modifier(MColor.DisabledText())
                        Text(sender)
                            .modifier(MFont.Headline(size: 16))
                            .modifier(MColor.Text())
                    }
                    VStack{
                        Text(message)
                            .modifier(MFont.Body(size: 18))
                            .modifier(MColor.Base())
                    }
                    .padding(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                    .background(
                        CRRectangle(color: MColor.ColorPalette().primary,
                                   tl: 18,tr: 0,bl: 18,br: 18)
                    )
                }
                .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 0))
                .modifier(MView.FillToRightFrame())
                
            case .away:
                VStack(alignment:.leading,spacing:4){
                    HStack{
                        Text(sender)
                            .modifier(MFont.Headline(size: 16))
                            .modifier(MColor.Text())
                        Text(time)
                            .modifier(MFont.Body(size: 16))
                            .modifier(MColor.DisabledText())
                    }
                    VStack{
                        Text(message)
                            .modifier(MFont.Body(size: 18))
                            .modifier(MColor.Text())
                    }
                    .padding(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                    .background(
                        CRRectangle(color: MColor.ColorPalette().primaryDisabled,
                                   tl: 0,tr: 18,bl: 18,br: 18)
                    )
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 36))
                .modifier(MView.FillToLeftFrame())
            }
        }.onAppear{
            print(">> \(time)")
            let t = TDate().stringToDate(date: time, format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
            time = TDate().dateToString(date: t,format: "dd MMMM, HH:mm")
        }
    }
}

struct CChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        CChatBubble(sender: "Me", time: "1 March - 14.27", message: "Aman gan, cuma agak linu-linu beberapa hari terakhir, agak maksa buat lari yang tempo hari lalu", style: .home)
        CChatBubble(sender: "Coach Budi", time: "1 March - 14.27", message: "Aman gan, cuma agak linu-linu beberapa hari terakhir, agak maksa buat lari yang tempo hari lalu", style: .away)
    }
}
