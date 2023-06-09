//
//  CGraph.swift
//  CoRun
//
//  Created by Marselus Richard on 13/04/23.
//

import SwiftUI
import Charts

struct CGraph: View {
    ///Define data for graph
    @ObservedObject var data: GraphDisplayDataList
    ///Define Bar Color
    let colors = [MColor.ColorPalette().primary,MColor.ColorPalette().danger]
    ///Define graph display mode
    var displayMode: GraphDisplayMode
    
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
      }

      var body: some View {
          Chart{
              ForEach(data.label.indices,id:\.self){ i in
                  if displayMode == .bar{
                      BarMark(
                        x: .value("Label",data.label[i]),
                        y: .value("Amount", data.amount[i]))
                  }
                  else if displayMode == .line{
                      LineMark(
                        x: .value("Label",data.label[i]),
                        y: .value("Amount", data.amount[i]))
                  }
              }
          }
      }
}

enum GraphDisplayMode{
    case bar
    case line
}

//struct CGraph_Previews: PreviewProvider {
//    static var previews: some View {
//        CGraph(data:GraphDisplayDataList(amount: [10,21,13,14,2,5,12,8,8,15],label:["J","F","M","A","M","Jn","Jl","Aug","Sep","Okt"]))
//    }
//}
