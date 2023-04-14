//
//  TraineeSummaryView.swift
//  CoRun
//
//  Created by Marselus Richard on 14/04/23.
//

import SwiftUI

struct TraineeSummaryView: View {
    var body: some View {
        VStack{
            ScrollView{
                SummaryView()
                
                //MARK: Biodata
                VStack(alignment: .leading,spacing: 18){
                    Text("Biodata")
                        .padding(EdgeInsets(top: 18, leading: 24, bottom: 0, trailing: 24))
                        .modifier(MFont.Headline(size:16))
                        .modifier(MColor.DisabledText())
                    
                    //MARK: Data
                    VStack(spacing: 12){
                        HStack{
                            Text("Name")
                                .modifier(MFont.Headline(size:18))
                                .modifier(MColor.Text())
                            Text("- NaN Years Old")
                                .modifier(MFont.Body(size:18))
                                .modifier(MColor.Text())
                        }.modifier(MView.FillToLeftFrame())
                        HStack{
                            HStack{
                                Image(systemName: "scalemass.fill")
                                    .modifier(MColor.Primary())
                                Text("NaN kg")
                                    .modifier(MColor.Text())
                            }.modifier(MView.FillToLeftFrame())
                            HStack{
                                Image(systemName: "ruler.fill")
                                    .modifier(MColor.Primary())
                                Text("NaN cm")
                                    .modifier(MColor.Text())
                            }.modifier(MView.FillToLeftFrame())
                            HStack{
                                Text("BMI")
                                    .modifier(MFont.Title(size:18))
                                    .modifier(MColor.Primary())
                                Text("NaN")
                                    .modifier(MColor.Text())
                            }.modifier(MView.FillToLeftFrame())
                        }
                    }.modifier(MView.safePadding())
                    
                    //MARK: Dismiss Button
                    Button{
                        //TODO: Dismiss Trainee
                    }label:{
                        Text("Dismiss")
                            .modifier(MFont.Headline(size:18))
                            .modifier(MColor.DisabledText())
                            .modifier(MView.FillToLeftFrame())
                    }.buttonStyle(MButton.ListButton())
                }
                .modifier(MView.FillToLeftFrame())
                .modifier(MView.Card())
            }
        }
    }
}

struct TraineeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeSummaryView()
    }
}
