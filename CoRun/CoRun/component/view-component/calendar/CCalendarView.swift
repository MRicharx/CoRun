//
//  CCalendarView.swift
//  CoRun
//
//  Created by Marselus Richard on 12/04/23.
//

import SwiftUI

struct CCalendarView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    ///Define selected date
    @Environment(\.selectedDate) var selected
    ///Define Session Data
    @ObservedObject var data : ListSessionDisplayData
    ///Define current view's view model
    @StateObject private var vm = CCalendarViewModel()
    
    var body: some View {
        VStack(spacing: 24){
            //MARK: Navigator
            HStack{
                Group{
                    Image(systemName: "chevron.left")
                        .onTapGesture{
                            vm.lastMonth()
                            vm.getDate(sessionData: data)
                        }
                        .modifier(MColor.Primary())
                    
                    //TODO: IMPLEMENT Date Picker
                    Text(TDate().dateToString(date: vm.curMonth, format: "MMMM YYYY"))
                        .modifier(MView.FillFrame())
                    
                    Image(systemName: "chevron.right")
                        .onTapGesture{
                            vm.nextMonth()
                            vm.getDate(sessionData: data)
                        }
                        .modifier(MColor.Primary())
                }.modifier(MFont.SubBody())
            }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            
            if vm.date.count > 0{
                VStack{
                    //MARK: Day Name
                    HStack{
                        Group{
                            Text("Su")
                            Text("M")
                            Text("Tu")
                            Text("W")
                            Text("Th")
                            Text("F")
                            Text("Sa")
                        }
                        .modifier(MFont.Headline(size:12))
                        .modifier(MColor.DisabledText())
                        .modifier(MView.FillFrame())
                    }
                    
                    //MARK: Calendar Implementation
                    LazyVGrid(columns: columns){
                        ForEach(vm.date.indices,id:\.self){i in
                            Group{
                                Day(day: vm.date[i])
                            }
                            .onTapGesture{
                                selected.wrappedValue = vm.date[i].date
    //                            self.updateDate(date)
                            }
                        }
                    }
                }
            }else{
                ProgressView()
                    .progressViewStyle(.circular)
            }
            }
        .padding(18)
        .modifier(MView.Card())
        .onChange(of: vm.reload){ new in
            if new{
                vm.getDate(sessionData: data)
            }
        }
        .onAppear{
            vm.getDate(sessionData: data)
        }
    }
}

class DayData:ObservableObject{
    ///Define date
    @Published var date = Date.now
    
    ///Define date number
    @Published var day:String = "-"
    ///Define this date plan status
    @Published var status = CompletionStatus()
    ///Define is this day selected
    @Published var isSelected:Bool = false
    ///Define is text need to be printed as disabled
    @Published var isDisabled:Bool = false
    
    init(){
        
    }
}

struct Day:View{
    ///Define selected date
    @Environment(\.selectedDate) private var selected
    @ObservedObject var day:DayData
    @State var isSelected = false
    
    
    var body: some View{
        ZStack(alignment:.center){
            //MARK: Background
            if isSelected{
                Circle()
                    .fill(MColor.ColorPalette().primary)
            }else if(TDate().compare(first: day.date, second: Date.now, format: "yyyy-MM-dd")){
                Circle()
                    .stroke(MColor.ColorPalette().primary, lineWidth: 2)
            }
            else{
                Circle()
                    .fill(MColor.ColorPalette().card)
            }
            
            //MARK: Content
            VStack(alignment:.center,spacing: 0){
                
                if isSelected{
                    Text(day.day)
                        .modifier(MFont.Headline(size:14))
                        .modifier(MColor.Base())
                    
                    if(day.status.int != 4){
                        Circle()
                            .fill(MColor.ColorPalette().base)
                            .frame(width: 8,height: 8)
                    }
                    else{
                        Circle()
                            .fill(MColor.ColorPalette().primary)
                            .frame(width: 8,height: 8)
                    }
                }
                else{
                    if(day.isDisabled){
                        Text(day.day)
                            .modifier(MFont.Headline(size:14))
                            .modifier(MColor.DisabledText())
                        Circle()
                            .fill(MColor.ColorPalette().card)
                            .frame(width: 8,height: 8)
                    }else{
                        Text(day.day)
                            .modifier(MFont.Headline(size:14))
                            .modifier(MColor.Text())
                        
                        switch day.status.int{
                        case 0:
                            Circle()
                                .fill(MColor.ColorPalette().danger)
                                .frame(width: 8,height: 8)
                        case 1:
                            Circle()
                                .fill(MColor.ColorPalette().alert)
                                .frame(width: 8,height: 8)
                        case 2:
                            Circle()
                                .fill(MColor.ColorPalette().primary)
                                .frame(width: 8,height: 8)
                        case 3:
                            Circle()
                                .fill(MColor.ColorPalette().textDisabled)
                                .frame(width: 8,height: 8)
                        default:
                            Circle()
                                .fill(MColor.ColorPalette().card)
                                .frame(width: 8,height: 8)
                        }
                    }
                }
            }
            .padding(4)
        }
        .onChange(of: selected.wrappedValue){newDate in
            if TDate().compare(first: day.date, second: newDate, format: "dd MMMM YYYY"){
                self.isSelected = true
            }else{
                self.isSelected = false
            }
        }
    }
}
//
//struct CCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CCalendarView()
//    }
//}
