//
//  CSearchBar.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

///CSearchBar - Custom Search Bar
///Custom component for search bar
///Parameter consist of hint and binded value
struct CSearchBar: View {
    ///Textfield default fill
    var hint:String = "Search"
    
    ///Binded input value
    @Binding var input:String
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8){
            ZStack{
                HStack{
                    ZStack{
                        if(input==""){
                            Text(hint)
                                .modifier(MColor.DisabledText())
                                .modifier(MFont.Body())
                                .modifier(MView.FillToLeftFrame())
                        }
                        TextField("", text: $input)
                        .textFieldStyle(PlainTextFieldStyle())
                        .disableAutocorrection(true)
                        .accentColor(MColor.ColorPalette().primary)
                        .modifier(MFont.Body())
                        .modifier(MColor.Text())
                    }
                    .modifier(MView.FillToLeftFrame())
                    
                    Image(systemName: "magnifyingglass")
                        .modifier(MColor.Primary())
                        .modifier(MFont.Body())
                }
            }
            .modifier(MView.FillFrame())
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(MColor.ColorPalette().textDisabled, lineWidth: 2)
            )
        }.modifier(MView.FillFrame())
    }
}
//struct CSearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CSearchBar()
//    }
//}
