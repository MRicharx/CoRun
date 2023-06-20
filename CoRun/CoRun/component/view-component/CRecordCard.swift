//
//  CRecordCard.swift
//  CoRun
//
//  Created by Marselus Richard on 19/06/23.
//

import SwiftUI

struct CRecordCard: View {
    var content : String
    var date: Date
    var writer: String
    
    var body: some View {
        VStack(alignment: .leading,spacing: 18){
            Text("\"\(content)\"")
                .modifier(MFont.Headline())
                .modifier(MColor.Text())
            HStack(spacing: 8){
                Group{
                    Text("Coach \(writer)")
                    Text("-")
                    Text(TDate().dateToString(date: date, format: "dd MMMM YYYY"))
                }
                .modifier(MFont.Caption2())
                .modifier(MColor.DisabledText())
            }
            .modifier(MView.FillToRightFrame())
        }
        .padding(24)
        .modifier(MView.Card())
    }
}

struct CRecordCard_Previews: PreviewProvider {
    static var previews: some View {
        CRecordCard(
            content: "Lorem Ipsum blara flskjfl asfkjliw\nLorem Ipsum blara flskjfl asfkjliw asfnoqiwrnkqwnlk", date: Date.now, writer: "Budi"
        )
    }
}
