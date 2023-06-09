//
//  QRPopUp.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct QRPopUp: View {
    let qr = TQR()
    
    ///Define user coach id
    @State var id:String
    ///Define if id copied to clipboard
    @State var showCopiedToast = false
    
    var body: some View {
        VStack(spacing: 24){
            //MARK: QR Section
            VStack(spacing:24){
                Group{
                    Text("Your Coach QR")
                    
                    Image(uiImage: qr.generateQRCode(from: id))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight:180)
                    
                    Text("Ask trainee to scan this QR Code")
                }
                .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
            }
            
            //MARK: Divider
            HStack(spacing: 18){
                CDivider(color: MColor.ColorPalette().textDisabled)
                
                Text("Or")
                    .modifier(MFont.Headline(size:16))
                    .modifier(MColor.DisabledText())
                
                CDivider(color: MColor.ColorPalette().textDisabled)
            }.modifier(MView.safePadding())
            
            //MARK: Copy ID Section
            VStack(spacing: 18){
                Text("Your Coach ID: ")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
                
                HStack(spacing: 18){
                    Group{
                        Text(id)
                            .multilineTextAlignment(.trailing)
                        Button{
                            //TODO: Copy ID to clipboard
                            UIPasteboard.general.string = id
                            showCopiedToast=true
                        }label:{
                            Image(systemName: "doc.on.clipboard.fill")
                                .modifier(MColor.Primary())
                                .modifier(MFont.Body())
                        }
                    }
                    .modifier(MFont.SubBody())
                }
                
                Text("Ask trainee to input this Code")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.Text())
            }
        }
        .padding(24)
        .alert(
            "ID Copied",
            isPresented: $showCopiedToast){
                Button{
                    //Do Nothing
                }label:{
                    Text("OK")
                }
            }
        
    }
}

struct QRPopUp_Previews: PreviewProvider {
    static var previews: some View {
        QRPopUp(id:"youtube.com")
    }
}
