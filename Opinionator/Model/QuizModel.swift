//
//  QuizModel.swift
//  Opinionator
//
//  Created by Felix Yu on 11/3/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation

struct QuizModel {
    let quizID: String
    let title: String
    var timestamp: Date!
    var creator: User
    var questions: [String]
    var answers: [[String]]
    var buckets: [[[String]]]
    var bucketNames: [String]
    
    init(creator: User, quizID: String, dictionary: [String: Any]) {
        self.quizID = quizID
        self.creator = creator
        
        self.title = dictionary["quizName"] as? String ?? ""
        self.questions = dictionary["questions"] as? [String] ?? []
        self.answers = dictionary["answers"] as? [[String]] ?? []
        self.buckets = dictionary["buckets"] as? [[[String]]] ?? []
        self.bucketNames = dictionary["bucketNames"] as? [String] ?? []
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
