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
    
    ///Define current view's view model
    @StateObject var vm = CCalendarViewModel()
    
    var body: some View {
        VStack(spacing: 24){
            //MARK: Navigator
            HStack{
                Group{
                    Image(systemName: "chevron.left")
                        .onTapGesture{
                            vm.lastMonth()
                        }
                        .modifier(MColor.Primary())
                    Text(TDate().dateToString(date: vm.curMonth, format: "MMMM YYYY"))
                        .modifier(MView.FillFrame())
                    Image(systemName: "chevron.right")
                        .onTapGesture{
                            vm.nextMonth()
                        }
                        .modifier(MColor.Primary())
                }.modifier(MFont.SubBody())
            }.padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            
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
                    ForEach(vm.date,id:\.self){date in
                        Group{
                            if(TDate().compare(first: date, second: selected.wrappedValue, format: "yyyy-MM-dd")){
                                Day(date:date,isSelected: true)
                            }
                            else if(TDate().compare(first: date, second: vm.curMonth, format: "MM")){
                                Day(date:date)
                            }
                            else{
                                Day(date:date,isDisabled: true)
                            }
                        }
                        .onTapGesture{
                            self.selected.wrappedValue = date
//                            self.updateDate(date)
                        }
                    }
                }
            
            }
            }
        .padding(18)
        .modifier(MView.Card())
        .onAppear{
            vm.getDate()
        }
    }
}

struct Day:View{
    ///Define date
    var date:Date
    
    ///Define date number
    @State var day:String = "-"
    ///Define this date plan status
    @State var status = CalendarStatus()
    ///Define is this day selected
    @State var isSelected:Bool = false
    ///Define is text need to be printed as disabled
    @State var isDisabled:Bool = false
    
    var body: some View{
        ZStack(alignment:.center){
            //MARK: Background
            if(isSelected){
                Circle()
                    .fill(MColor.ColorPalette().primary)
            }else if(TDate().compare(first: date, second: Date.now, format: "yyyy-MM-dd")){
                Circle()
                    .stroke(MColor.ColorPalette().primary, lineWidth: 2)
            }
            else{
                Circle()
                    .fill(MColor.ColorPalette().card)
            }
            
            //MARK: Content
            VStack(alignment:.center,spacing: 0){
                
                if(isSelected){
                    Text(day)
                        .modifier(MFont.Headline(size:14))
                        .modifier(MColor.Base())
                    
                    if(status.int != 0){
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
                    if(isDisabled){
                        Text(day)
                            .modifier(MFont.Headline(size:14))
                            .modifier(MColor.DisabledText())
                        Circle()
                            .fill(MColor.ColorPalette().card)
                            .frame(width: 8,height: 8)
                    }else{
                        Text(day)
                            .modifier(MFont.Headline(size:14))
                            .modifier(MColor.Text())
                        
                        switch status.int{
                        case 0:
                            Circle()
                                .fill(MColor.ColorPalette().card)
                                .frame(width: 8,height: 8)
                        case 1:
                            Circle()
                                .fill(MColor.ColorPalette().danger)
                                .frame(width: 8,height: 8)
                        case 2:
                            Circle()
                                .fill(MColor.ColorPalette().alert)
                                .frame(width: 8,height: 8)
                        case 3:
                            Circle()
                                .fill(MColor.ColorPalette().primary)
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
        .onAppear{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"

            day = dateFormatter.string(from: date)
        }
    }
}

struct CCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CCalendarView()
    }
}
