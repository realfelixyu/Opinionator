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
    
    //initializes question array in quizmodel
    func newQuestion() {
        var newQuestion = QuestionModel()
        newQuestion.title = ""
        newQuestion.answers = Array(repeating: "", count: 4)
        newQuestion.bucketValues = Array(repeating: Array(repeating: 0.0, count: quizModel.quizBuckets!.count), count: 4)
        quizModel.questions.append(newQuestion)
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
        quizModel.questions[questionIndex].answers![answerIndex] = answerText
    }
    
    func saveBucketPoints(questionIndex: Int, answerIndex: Int, points: [Float]) {
        if (quizModel.questions.count == questionIndex) {
            quizModel.questions.append(QuestionModel())
        }
        quizModel.questions[questionIndex].bucketValues![answerIndex] = points
    }
    
    func getBuckets() -> [String] {
        return quizModel.quizBuckets ?? [""]
    }
    
    func getBucketPoints(questionIndex: Int, answerIndex: Int) -> [Float] {
        return quizModel.questions[questionIndex].bucketValues![answerIndex]
    }
    
    func getAnswers(questionIndex: Int) -> [String] {
        return quizModel.questions[questionIndex].answers ?? Array(repeating: "Error Occursed 59 in QuizCreationManager", count: 4)
    }
    
    func getQuestionText(questionIndex: Int) -> String {
        return quizModel.questions[questionIndex].title ?? "cannot find the question title"
    }
}
