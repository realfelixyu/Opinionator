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
    var quizIconURL: URL?
    
    init(creator: User, quizID: String, dictionary: [String: Any]) {
        self.quizID = quizID
        self.creator = creator
        
        self.title = dictionary["quizTitle"] as? String ?? ""
        self.questions = dictionary["questionTitles"] as? [String] ?? []
        self.answers = dictionary["answerTitles"] as? [[String]] ?? []
        self.buckets = dictionary["bucketData"] as? [[[Float]]] ?? []
        self.bucketNames = dictionary["bucketNames"] as? [String] ?? []
        var imageURLs = dictionary["imageURLs"] as? [String] ?? []
        var imageURLIndexs = dictionary["bucketImageIndexs"] as? [Int] ?? []
        self.bucketImageURLs = [Int: URL]()
        for (index, str) in imageURLs.enumerated() {
            self.bucketImageURLs[imageURLIndexs[index]] = URL(string: str)
        }
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        self.quizIconURL = URL(string: dictionary["quizIconURL"] as? String ?? "")
    }
}
