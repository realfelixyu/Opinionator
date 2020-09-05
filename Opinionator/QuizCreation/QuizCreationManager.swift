//
//  QuizCreationManager.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation

class QuizCreationManager {
    var quizModel: QuizModel
    
    init() {
        quizModel = QuizModel()
    }
    
    func saveName(name: String) {
        quizModel.quizName = name
    }
    
    func saveBuckets(buckets: [String]) {
        quizModel.quizBuckets = buckets
    }
    
    func saveQuestionText(questionIndex: Int, questionText: String) {
        quizModel.questions[questionIndex].title = questionText
    }
    
    func saveAnswer(questionIndex: Int, answerIndex: Int, answerText: String) {
        quizModel.questions[questionIndex].answers[answerIndex] = answerText
    }
    
    func saveBucketPoints(questionIndex: Int, answerIndex: Int, points: [Double]) {
        quizModel.questions[questionIndex].bucketValues[answerIndex] = points
    }
}
