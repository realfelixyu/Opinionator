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
    var bucketValues: [Float]
    
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
    
    private var answerButtons = [UIButton(type: .system), UIButton(type: .system), UIButton(type: .system), UIButton(type: .system)]
    
    init(quiz: QuizModel) {
        self.quiz = quiz
        self.bucketValues = Array(repeating: 0.0, count: quiz.bucketNames.count)
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
        updateUIScreenValues()
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
        for (index, button) in answerButtons.enumerated() {
            button.tag = index
            button.layer.borderColor = UIColor.systemGreen.cgColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 20
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.addTarget(self, action: #selector(handleAnswerButtonTapped), for: .touchUpInside)
            button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            view.addSubview(button)
            if (index == 0) {
                button.anchor(top: questionTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
            } else {
                button.anchor(top: answerButtons[index - 1].bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
            }
        }
        
    }
    
    func updateUIScreenValues() {
        questionTextView.text = quiz.questions[currQuestionIndex]
        questionTextView.centerVertically()
        print("DEBUG \(quiz.answers[currQuestionIndex])")
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(quiz.answers[currQuestionIndex][index], for: .normal)
        }
    }
    
    func updateBuckets(answerIndex: Int) {
        for i in 0..<bucketValues.count {
            bucketValues[i] += quiz.buckets[currQuestionIndex][answerIndex][i]
        }
        print("DEBUG: \(bucketValues)")
    }
    func obtainResult() -> String {
        var max = Float.leastNormalMagnitude
        var maxIndex = 0
        for i in 0..<bucketValues.count {
            if (bucketValues[i] > max) {
                max = bucketValues[i]
                maxIndex = i
            }
        }
        return quiz.bucketNames[maxIndex]
    }
    
    @objc func handleAnswerButtonTapped(button: UIButton) {
        updateBuckets(answerIndex: button.tag)
        currQuestionIndex += 1
        if (currQuestionIndex >= quiz.questions.count) {
            navigationController?.popViewController(animated: true)
            let controller = QuizResultController(result: obtainResult())
            navigationController?.pushViewController(controller, animated: true)
        } else {
            updateUIScreenValues()
        }
    }
}
