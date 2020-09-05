//
//  QuizModel.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation

struct QuizModel {
    
    var quizName: String?
    var questions = [QuestionModel]()
    var quizBuckets: [String]?
    
}
