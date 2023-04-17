//
//  FeedbackData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class FeedbackData:Codable{
    ///Define feedback id
    var id = ""
    ///Define feedback sender id
    var senderID = ""
    ///Define feedback sender role (coach or trainee)
    var senderRole = 0
    ///Define feedback sender name
    var senderName = ""
    ///Define feedback sent date
    var date = Date.now
    ///Define feedback content
    var content = ""
    ///Define if feedback is read
    var isRead = true
}
