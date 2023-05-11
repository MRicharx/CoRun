//
//  CalendarView.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject private var pvm : TrainingViewModel
    @StateObject var vm = CalendarViewModel()
    
    var body: some View {
        VStack(spacing:12){
            if vm.isLoaded{
                CCalendarView(data: ListSessionDisplayData(list: vm.sessionDD))
            }
            
            //MARK: Session View
            VStack{
                //MARK: Session Detail
                VStack{
                    if vm.selectedSession.status.int < 4{
                        NavigationLink{
                            SessionDetailView(data: vm.selectedSession)
                        }label: {
                            HStack{
                                CSessionCard(data: vm.selectedSession)
                                Image(systemName: "chevron.right")
                                    .modifier(MColor.Primary())
                            }
                        }
                    }
                    else{
                        CSessionCard(data: vm.selectedSession)
                    }
                }
                .padding(24)
                
            }.modifier(MView.Card())
            Spacer()
            
        }
        .onChange(of: vm.selectedDate){ newDate in
            let d = newDate
            vm.findSession(byDate: d)
        }
        .task{
            vm.loadSession(session: pvm.pubSes)
        }
        .environment(\.selectedDate, $vm.selectedDate) //Set environment object
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
