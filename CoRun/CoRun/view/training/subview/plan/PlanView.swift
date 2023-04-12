//
//  TrainingPlanView.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct PlanView: View {
    //@State var displayOption:String = "rectangle.grid.1x2"
    
    var body: some View {
        VStack(spacing: 12){
            //MARK: Progress Bar
            VStack{
                HStack{
                    Text("To do this week")
                        .modifier(MFont.Headline(size: 18))
                        .modifier(MColor.Text())
                        .modifier(MView.FillToLeftFrame())
                    
                    Text("Completed x of X")
                        .modifier(MFont.Caption1())
                        .modifier(MColor.DisabledText())
                }
                HStack{
                    ForEach(0...5,id:\.self){ i in
                        CDivider(weight:4,color: MColor.ColorPalette().textDisabled, cornerRadius: 4)
                    }
                }
            }
            .padding(24)
            .modifier(MView.Card())
            
            //MARK: Session List
            VStack{
                //CSessionCard()
                
                Spacer()
            }
            .padding(24)
            .modifier(MView.Card())
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
