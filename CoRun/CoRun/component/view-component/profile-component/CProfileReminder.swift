//
//  CProfileReminder.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct CProfileReminder: View {
    ///Define reminder activeness
    @State var isReminderActive:Bool = true
    
    var body: some View {
        VStack(spacing: 18){
            //MARK: Title
            HStack(spacing : 12){
                Group{
                    Image(systemName: "alarm.waves.left.and.right.fill")
                        .modifier(MColor.Primary())
                    Text("Reminder")
                        .modifier(MColor.Text())
                        .modifier(MView.FillToLeftFrame())
                    
                    Toggle("", isOn: $isReminderActive)
                }.modifier(MFont.Headline())
            }
            .modifier(MView.FillToLeftFrame())
            
            //MARK: Content
            VStack(alignment:.leading,spacing: 6){
                Text("Current Coach")
                    .modifier(MFont.Headline(size:18))
                    .modifier(MColor.DisabledText())
                if(isReminderActive){
                    Text("05:00")
                        .modifier(MFont.Headline())
                        .foregroundColor(MColor.ColorPalette().textDefault)
                }else{
                    Text("05:00")
                        .modifier(MFont.Headline())
                        .foregroundColor(MColor.ColorPalette().textDisabled)
                }
            }.modifier(MView.FillToLeftFrame())
            
        }.padding(18)
            .modifier(MView.Card())
    }
}

struct CProfileReminder_Previews: PreviewProvider {
    static var previews: some View {
        CProfileReminder()
    }
}
