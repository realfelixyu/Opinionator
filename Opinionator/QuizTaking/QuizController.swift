//
//  QuizController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/9/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class QuizController: UIViewController {
    
    var quiz: QuizModel
    var currQuestionIndex = 0
    
//    private lazy var questionTitleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 35)
//        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
//        label.backgroundColor = .white
//        label.
//        return label
//    }()
    
    private lazy var questionTitleView: UITextView = {
        var tv = UITextView()
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 35)
        tv.backgroundColor = .white
        return tv
    }()
    
    private let questionTextView = UITextView(frame: CGRect(x: 20, y: getTopSafeAreaHeight() + 70, width: UIScreen.main.bounds.width - 40, height: 200))
    
    private var ansButtons = [[UIButton(), UIButton()], [UIButton(), UIButton()]]
    
    init(quiz: QuizModel) {
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
        
//        questionTitleView.text = quiz.questions[currQuestionIndex]
//        view.addSubview(questionTitleView)
//        questionTitleView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        configureAnswerButtons()
        configureAnswerButtonValues()
    }
    
    func configureTextView() {
        questionTextView.text = quiz.questions[currQuestionIndex]
        questionTextView.font = UIFont.systemFont(ofSize: 30)
        questionTextView.textAlignment = .center
        questionTextView.textColor = .black
        questionTextView.backgroundColor = .white
        questionTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        questionTextView.layer.cornerRadius = 20
        questionTextView.centerVertically()
        view.addSubview(questionTextView)
    }
    
    func configureAnswerButtons() {
        var counter = 0
        for buttonList in ansButtons {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            for button in buttonList {
                button.tag = counter
                counter += 1
                button.layer.borderColor = UIColor.twitterBlue.cgColor
                button.layer.borderWidth = 1.25
                button.setTitleColor(.twitterBlue, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
                button.addTarget(self, action: #selector(handleAnswerButtonTapped), for: .touchUpInside)
            }
        }
    }
    
    func configureAnswerButtonValues() {
        
    }
    
    @objc func handleAnswerButtonTapped() {
        
    }
}
