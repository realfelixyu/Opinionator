//
//  QuizCellViewModel.swift
//  Opinionator
//
//  Created by Felix Yu on 11/6/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

struct QuizCellViewModel {
    
    let quiz: QuizModel
    let quizCreator: User
    
    var profileImageURL: URL? {
        return quizCreator.profileImageUrl
    }
    
    init(quiz: QuizModel) {
        self.quiz = quiz
        self.quizCreator = quiz.creator
    }
    
    
}
