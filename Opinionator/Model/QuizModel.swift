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
    var buckets: [[[Float]]]
    var bucketNames: [String]
    var bucketImageURLs: [Int: URL]
    
    init(creator: User, quizID: String, dictionary: [String: Any]) {
        self.quizID = quizID
        self.creator = creator
        
        self.title = dictionary["quizTitle"] as? String ?? ""
        self.questions = dictionary["questionTitles"] as? [String] ?? []
        self.answers = dictionary["answerTitles"] as? [[String]] ?? []
        self.buckets = dictionary["bucketData"] as? [[[Float]]] ?? []
        self.bucketNames = dictionary["bucketNames"] as? [String] ?? []
        self.bucketImageURLs = dictionary["imageURLs"] as? [Int: URL] ?? [:]
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
