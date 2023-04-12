//
//  CalendarView.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import SwiftUI

struct CalendarView: View {
    ///Define selected date
    @State var selectedDate = Date.now
    ///Define list of plan
    
    var body: some View {
        VStack(spacing:12){
            CCalendarView()
            
            //MARK: Session View
            VStack{
                //MARK: Session Detail
                VStack{
                    CSessionCard(time: $selectedDate)
                }
                .padding(24)
                
                //MARK: Button List
                VStack{
                    Button{
                        //TODO: Navigate to Feedback
                    }label:{
                        HStack{
                            Text("Feedback")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.Text())
                                .modifier(MView.FillToLeftFrame())
                            Image(systemName: "chevron.right")
                                .modifier(MFont.SubBody())
                                .modifier(MColor.DisabledText())
                        }
                    }.buttonStyle(MButton.ListButton())
                }
            }.modifier(MView.Card())
            
            Spacer()
            
        }.environment(\.selectedDate, $selectedDate) //Set environment object
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
