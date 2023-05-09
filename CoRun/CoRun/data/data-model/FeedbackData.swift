//
//  FeedbackData.swift
//  CoRun
//
//  Created by Marselus Richard on 17/04/23.
//

import Foundation

class FeedbackData:Codable{
    ///Define session  id
    var id = 0
    ///Define feedback sender id
    var senderID = ""
    ///Define feedback sent date
    var sentDate = ""
    ///Define feedback content
    var content = ""
    ///Define if feedback is read
    var status = false
}
