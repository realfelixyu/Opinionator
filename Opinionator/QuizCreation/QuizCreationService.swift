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
    
    func uploadNewQuiz(quizTitle: String, questionTitles: [String], answerTitles: [[String]], bucketData: [[[Float]]], bucketNames: [String], bucketImages: [UIImage], bucketImageIndex: [Int]) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        var values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "quizTitle": quizTitle, "questionTitles": questionTitles, "answerTitles": answerTitles, "bucketData": bucketData, "bucketNames": bucketNames, "bucketImageIndexs": bucketImageIndex] as [String: Any]
        uploadQuizImages(images: bucketImages) { (imagesURLStrings) in
            values["imageURLs"] = imagesURLStrings
            REF_QUIZ.childByAutoId().updateChildValues(values) { (err, ref) in
                if err == nil {
                    guard let key = ref.key else {return}
                    REF_QUIZTITLES.updateChildValues([quizTitle: key])
                    print("DEBUG: upload QUIZ success")
                }
            }
        }
    }
    
    func uploadQuizImages(images: [UIImage], completion: @escaping([String]) -> Void) {
        var imagesURLs = [String]()
        let group = DispatchGroup()
        for (index, image) in images.enumerated() {
            guard let imageData = image.jpegData(compressionQuality: 0.3) else {return}
            
            let filename = NSUUID().uuidString
            let ref = STORAGE_QUIZ_IMAGES.child(filename)
            //intended to finish all uploading of images before calling completion
            group.enter()
            ref.putData(imageData, metadata: nil) { (meta, err) in
                ref.downloadURL { (url, err) in
                    guard let urlString = url?.absoluteString else {return}
                    imagesURLs.append(urlString)
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            completion(imagesURLs)
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
