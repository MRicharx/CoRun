//
//  TraineeSummaryViewModel.swift
//  CoRun
//
//  Created by Marselus Richard on 22/04/23.
//

import Foundation

class TraineeSummaryViewModel:SummaryViewModel{
    @Published var isAccepting = false
    @Published var isDeclining = false
    @Published var isDismissing = false
    
    @Published var showDismissAlert = false
    
    @Published var bmi = 0.0
    
    ///Define scoredata
    @Published var scoreData = GraphDisplayDataList(amount: [],label:[])
    private var scoreCounter = [Int]()
    
    override func loadData(session: [SessionData]) {
        super.loadData(session: session)
        
        scoreData.clear()
        scoreCounter.removeAll()
        
        ///Calculate score data for graph
        ///Calculation by year require average
        if displayOption == "Year"{
            ///Insert empty label to graph data
            for val in label{
                scoreData.amount.append(0)
                scoreData.label.append(val)
                scoreCounter.append(0)
            }
            
            ///Classified data based on month
            for data in session{
                if data.Status != 3{
                    let date = TDate().stringToDate(date: data.SessionDate, format: "yyyy-MM-dd")
                    let month = Int(TDate().dateToString(date: date,format: "M")) ?? 1
                    
                    scoreData.amount[month-1]+=Double(data.Score)
                    scoreCounter[month-1]+=1
                }
            }
            
            ///Calculate average
            for i in scoreData.amount.indices{
                if scoreCounter[i]>0{
                    scoreData.amount[i] = scoreData.amount[i]/Double(scoreCounter[i])
                }
            }
        }
        else if displayOption == "Month"{
            var weekBound = [Date]()
            var date = start
            for i in 1...5{
                weekBound.append(date.next(.saturday))
                date = date.next(.saturday)
                
                scoreData.amount.append(0)
                scoreData.label.append("W\(i)")
                scoreCounter.append(0)
            }
            
            for data in session{
                let date = TDate().stringToDate(date: data.SessionDate, format: "yyyy-MM-dd")
                
                if data.Status != 3{
                    ///Check if data satisfied the date range
                    ///and append to graph data
                    if start < date && date < end{
                        for i in weekBound.indices {
                            if date < weekBound[i]{
                                scoreData.amount[i] += Double(data.Score)
                                scoreCounter[i] += 1
                                break
                            }
                        }
                    }
                }
            }
            
            ///Calculate average
            for i in scoreData.amount.indices{
                if scoreCounter[i]>0{
                    scoreData.amount[i] = scoreData.amount[i]/Double(scoreCounter[i])
                }
            }
        }
        else{
            for data in session{
                let date = TDate().stringToDate(date: data.SessionDate, format: "yyyy-MM-dd")
                
                ///Check if data satisfied the date range
                ///and append to graph data
                if start < date && date < end{
                    ///If session have result
                    if data.Status != 3{
                        scoreData.amount.append(Double(data.Score))
                        scoreData.label.append(TDate().dateToString(date: date,format: "EE"))
                    }
                }
            }
            
            if scoreData.amount.count<=0{
                scoreData.amount.append(0)
                scoreData.label.append("-")
            }
        }
    }
    
    func updateBMI(height:Int, weight:Int){
        bmi = Double(weight) / ((Double(height)*Double(height))/10000)
    }
}
