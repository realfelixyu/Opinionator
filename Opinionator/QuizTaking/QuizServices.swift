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
    
    func updateQuizStats(quizID: String, timesTaken: Int, bucketDistribution: [Int], answerDistribution: [[Int]]) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        REF_QUIZ.child(quizID).updateChildValues(["timesTaken": timesTaken, "bucketDistribution": bucketDistribution, "answerDistribution": answerDistribution]) { (err, ref) in
            print("DEBUG: successfully updated quiz stats")
        }
    }
}
