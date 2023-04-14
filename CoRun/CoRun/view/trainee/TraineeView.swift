//
//  TraineeView.swift
//  CoRun
//
//  Created by Marselus Richard on 29/03/23.
//

import SwiftUI

struct TraineeView: View {
    ///Define which tab will be shown
    @State var selectedTab:String = "Calendar"
    ///Define trainee name
    @State var traineeName:String = "Budi"
    
    var body: some View {
        VStack(spacing: 12){
            CTabControl(tab: $selectedTab,title: "\(traineeName) Plan",tabList: ["Calendar", "Summary"])
            
            switch(selectedTab){
            case "Calendar":
                TraineeCalendarView()
            case "Summary":
                TraineeSummaryView()
            default:
                Text("NaN")
            }
            
            Spacer()
        }
    }
}

struct TraineeView_Previews: PreviewProvider {
    static var previews: some View {
        TraineeView()
    }
}
