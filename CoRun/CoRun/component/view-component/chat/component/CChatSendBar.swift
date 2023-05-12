//
//  CChatSendBar.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI

struct CChatSendBar: View {
    @EnvironmentObject var own:ProfileData
    @EnvironmentObject var pvm: SessionDetailViewModel
    
    ///Define textfield input value
    @State var input:String = ""
    ///Define Hint Value
    let hint = "Send feedback"
    
    @State var isSending = false
    
    var body: some View {
        //MARK: TEXTFIELD
        HStack(spacing: 18){
            ZStack{
                if(input.isEmpty){
                    Text(hint)
                        .modifier(MColor.DisabledText())
                        .modifier(MFont.Body(size:16))
                        .modifier(MView.FillToLeftFrame())
                }
                TextField("", text: $input,axis: .vertical)
                    .modifier(MFont.Body(size:16))
                    .modifier(MView.FillToLeftFrame())
                    .lineLimit(3)
            }
            .padding(EdgeInsets(top: 12, leading: 18, bottom: 12, trailing: 18))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(MColor.ColorPalette().primaryDisabled, lineWidth: 2)
            )
            
            //MARK: SEND BUTTON
            if(input.isEmpty){
                Button{
                    //DO NOTHING
                }label:{
                    Image(systemName: "paperplane.fill")
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.Base())
                }.buttonStyle(MButton.SquareButton(isActive: false))
            }else{
                Button{
                    //TODO: Send Feat
                    if !(isSending){
                        isSending = true
                    }
                }label:{
                    if isSending{
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    else{
                        Image(systemName: "paperplane.fill")
                            .modifier(MFont.Headline(size:16))
                    }
                }.buttonStyle(MButton.SquareButton(isActive: true))
            }
        }
        .onChange(of: isSending){ cur in
            if cur{
                Task{
                    await pvm.pushFeedback(ownId: own.UserId,input: input)
                    input = ""
                    isSending = false
                    pvm.refreshDisplayData()
                }
            }
        }
    }
}

//struct CChatSendBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CChatSendBar()
//    }
//}
