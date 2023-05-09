//
//  FeedbackData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class FeedbackData:Codable{
    ///Define feedback  id
    var FeedbackId = 0
    ///Define session  id
    var SessionId = 0
    ///Define feedback sender id
    var SenderId = ""
    ///Define feedback sent date
    var SentDate = ""
    ///Define feedback content
    var Content = ""
    ///Define if feedback is read
    var Status = 0
}
