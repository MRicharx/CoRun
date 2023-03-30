//
//  CCalendarCard.swift
//  CoRun
//
//  Created by Marselus Richard on 24/03/23.
//

import SwiftUI

struct CCalendarCard: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    ///Define current date
    @State var month:Date = Date.now
    ///Define selected date
    @State var selected:Date = Date.now
    ///Define date
    @State var date:[Date] = [Date]()
    
    ///Define current view's view model
    @StateObject var vm = CCalendarCardViewModel()
    
    var body: some View {
        VStack{
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
                .modifier(MFont.Headline(size:18))
                .modifier(MColor.Base())
                .modifier(MView.FillFrame())
            }
            .modifier(MView.Background(color: MColor.ColorPalette().primary,cornerRadius: 12, padding: EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)))
            
            //MARK: Calendar Implementation
            LazyVGrid(columns: columns){
                ForEach(date,id:\.self){date in
                    Group{
                        if(TDate().compare(first: date, second: selected, format: "yyyy-MM-dd")){
                            Day(date:date,isSelected: true)
                        }
                        else if(TDate().compare(first: date, second: month, format: "MM")){
                            Day(date:date)
                        }
                        else{
                            Day(date:date,isDisabled: true)
                        }
                    }
                    .onTapGesture{
                        selected = date
                    }
                }
            }
        }
        .padding(18)
        .modifier(MView.Card())
        .onAppear{
            date = vm.generateDate(month: month)
        }
    }
}

struct Day:View{
    ///Define date
    var date:Date
    
    ///Define date number
    @State var day:String = "-"
    ///Define this date plan status
    ///0 - plan did not exist,
    ///1 - Goal not reached,
    ///2 - Some Goal reached,
    ///3 - All goal reached,
    ///else - Activity yet to be done
    @State var planStatus:Int = 0
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
                    
                    if(planStatus != 0){
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
                        
                        switch planStatus{
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
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d"

            day = dateFormatter.string(from: date)
        }
    }
}

struct CCalendarCard_Previews: PreviewProvider {
    static var previews: some View {
        CCalendarCard()
    }
}
