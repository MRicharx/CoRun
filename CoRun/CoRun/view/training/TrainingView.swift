//
//  TrainingView.swift
//  CoRun
//
//  Created by Marselus Richard on 11/04/23.
//

import SwiftUI

struct TrainingView: View {
    ///Define selected tab
    @State var selectedTab  = "Plan"
    
    var body: some View {
        VStack(spacing:12){
            CTabControl(tab: $selectedTab)
            
            switch(selectedTab){
            case "Plan":
                PlanView()
            case "Calendar":
                CalendarView()
            case "Summary":
                SummaryView()
            default:
                Text("NaN")
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
