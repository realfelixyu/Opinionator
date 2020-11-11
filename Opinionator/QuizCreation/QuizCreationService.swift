//
//  QuizCreationService.swift
//  Opinionator
//
//  Created by Felix Yu on 11/6/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import Firebase

struct QuizCreationService {
    static let shared = QuizCreationService()
    
    func uploadNewQuiz(quizTitle: String, questionTitles: [String], answerTitles: [[String]], bucketData: [[[Float]]], bucketNames: [String]) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        var values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "quizTitle": quizTitle, "questionTitles": questionTitles, "answerTitles": answerTitles, "bucketData": bucketData, "bucketNames": bucketNames] as [String: Any]
        
        REF_QUIZ.childByAutoId().updateChildValues(values) { (err, ref) in
            if err == nil {
                guard let key = ref.key else {return}
                REF_QUIZTITLES.updateChildValues([quizTitle: key])
                print("DEBUG: upload QUIZ success")
            }
        }
        
    }
    
//    func fetchQuiz(userID: String, completion: @escpaing(Tweet) -> Void) {
//        REF_QUIZ.child(
//    }
    
    func fetchQuizzes(completion: @escaping([QuizModel]) -> Void) {
        var quizzes = [QuizModel]()
        
        DB_REF.child("quizzes").observe(.childAdded) { (snapshot) in
            print("DEBUG: in completion block for fetching quizzes")
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let quiz = QuizModel(creator: user, quizID: snapshot.key, dictionary: dictionary)
                quizzes.append(quiz)
                print("DEBUG: \(dictionary)")
                completion(quizzes)
            }
            
        }
    }
}
