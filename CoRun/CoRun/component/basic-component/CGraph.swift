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
    var data: [Double]
    ///Define Bar Color
    let colors = [MColor.ColorPalette().primary,MColor.ColorPalette().danger]

    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
      }

      var body: some View {
          Chart{
//              BarMark(x: .value("Month","This"),
//                      y: .value("Value", data[0]))
//
//              BarMark(x: .value("Month","That"),
//                      y: .value("Value", data[1]))
              
//              ForEach(0..<data.count-1, id:\.self){ i in
//                  BarMark(x: .value("Month",i),
//                          y: .value("Value", data[i]))
//              }
              
              ForEach(data,id:\.self){ val in
                  BarMark(x: .value("Month","\(val)"),y: .value("Value", val))
              }
          }
      }
}

struct CGraph_Previews: PreviewProvider {
    static var previews: some View {
        CGraph(data:[10,21,13,14,2,5,12,8,8,15])
    }
}
