//
//  CalendarView.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import SwiftUI

struct CalendarView: View {
    @StateObject var vm = CalendarViewModel()
    
    var body: some View {
        VStack(spacing:12){
            CCalendarView(data: ListSessionDisplayData(list: vm.sessionDD))
            
            //MARK: Session View
            VStack{
                //MARK: Session Detail
                VStack{
                    CSessionCard(data: vm.selectedSession)
                }
                .padding(24)
                
                //MARK: Button List
                if vm.isSessionExist{
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
                }
            }.modifier(MView.Card())
            Spacer()
            
        }
        .onChange(of: vm.selectedDate){ newDate in
            let d = newDate
            vm.findSession(byDate: d)
        }
        .onAppear{
            if vm.sessionDD.isEmpty{
                vm.loadSession()
            }
        }
        .environment(\.selectedDate, $vm.selectedDate) //Set environment object
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
