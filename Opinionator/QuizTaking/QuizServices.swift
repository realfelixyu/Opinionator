//
//  QuizServices.swift
//  Opinionator
//
//  Created by Felix Yu on 11/16/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import Firebase

struct QuizServices {
    static let shared = QuizServices()
    
    func updateQuizStats(quiz: QuizModel, completion: @escaping() -> Void) {
        print("DEBUG: entering updateQuizStats")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        REF_QUIZ.child(quiz.quizID).updateChildValues(["timesTaken": quiz.timesTaken, "bucketDistribution": quiz.bucketDistribution, "answerDistribution": quiz.answerDistribution]) { (err, ref) in
            print("DEBUG: successfully updated quiz stats")
            completion()
        }
    }
    
    func reFetchQuiz(quiz: QuizModel, completion: @escaping(QuizModel) -> Void) {
        print("DEBUG: entering reFetchQuiz")
        DB_REF.child("quizzes").child(quiz.quizID).observeSingleEvent(of: .value) { (snapshot) in
            //print("DEBUG: in completion block for fetching quiz with quizID")
            print("DEBUG: fetched quiz in reFetchQuiz")
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            var quiz = QuizModel(creator: quiz.creator, quizID: quiz.quizID, dictionary: dictionary)
            completion(quiz)
        }
    }
}
