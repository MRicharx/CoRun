//
//  CTabControl.swift
//  CoRun
//
//  Created by Marselus Richard on 11/04/23.
//

import Foundation
import SwiftUI

enum TabList{
    case training
    case calendar
    case summary
}

struct CTabControl: View {
    ///Define selected tab
    @Binding var tab:String
    ///Define tab list
    @State var tabList = ["Plan","Calendar","Summary"]
    
    ///Update selected tab
    private func updateTab(new:String){
        tab=new
    }
    
    var body: some View {
        VStack(spacing:18){
            //MARK: Title
            Text("Training")
                .modifier(MFont.Headline())
                .modifier(MColor.Text())
                .modifier(MView.FillToLeftFrame())
            
            //MARK: Tab List
            HStack(spacing:36){
                ForEach(tabList, id: \.self){ item in
                    //MARK: Selected Tab
                    if(item == tab){
                        VStack(spacing:8){
                            Text(item)
                                .modifier(MFont.SubBody())
                                .modifier(MColor.Text())
                            CDivider(isHorizontal: true,weight: 3,color: MColor.ColorPalette().primary)
                                .frame(maxWidth: 48)
                        }.onTapGesture {
                            updateTab(new: item)
                        }
                    }
                    //MARK: Default Tab
                    else{
                        VStack{
                            Text(item)
                                .modifier(MFont.SubBody())
                                .modifier(MColor.Text())
                            CDivider(isHorizontal: true,weight: 3,color: MColor.ColorPalette().card)
                                .frame(maxWidth: 48)
                        }.onTapGesture {
                            updateTab(new: item)
                        }
                    }
                }
                Spacer()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 8, trailing: 24))
        .modifier(MView.Card())
    }
}
