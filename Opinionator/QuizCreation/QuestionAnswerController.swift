//
//  QuestionAnswerController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/30/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class QuestionAnswerController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var questionSectionLabel = UILabel()
    var answerSectionLabel = UILabel()
    var questionField = UITextView()
    var answerFields = [UITextField(), UITextField(), UITextField(), UITextField()]
        //Array(repeating: UITextField(), count: 4)
    var scrollView = UIScrollView()
    var prevButton = UIButton()
    var nextButton = UIButton()
    var footorStack = UIStackView()
    var stackView = UIStackView()
    var finishCreationButton = UIButton()
    var currQuestionIndex = 0;
    
    var quizManager: QuizCreationManager
    
    init(quizManager: QuizCreationManager) {
        self.quizManager = quizManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizManager.newQuestion()
        loadScrollView()
        loadStackView()
        loadFooterButtons()
        loadFinishCreationButton()
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        navigationItem.title = "Write Question \(currQuestionIndex + 1)"
    }
    
    func loadStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        loadHeader()
        loadAnswerFields()
    }
    
    func loadHeader() {
        questionSectionLabel.text = "Question Text:"
        questionField.backgroundColor = .gray
        questionField.text = "test"
        questionField.font = UIFont.systemFont(ofSize: 20)
        questionField.layer.cornerRadius = 5
        questionField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        answerSectionLabel.text = "Answers"
        answerSectionLabel.font = UIFont.systemFont(ofSize: 20)
        
        stackView.addArrangedSubview(questionSectionLabel)
        stackView.addArrangedSubview(questionField)
        stackView.addArrangedSubview(answerSectionLabel)

        questionSectionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(LayoutHelper.relativeWidth(percentOfScreen: 80))
            make.height.equalTo(LayoutHelper.relativeHeight(percentOfScreen: 8))
            make.margins.equalTo(10)
        }
        
        questionField.snp.makeConstraints { (make) in
            make.width.equalTo(LayoutHelper.relativeWidth(percentOfScreen: 80))
            make.height.equalTo(LayoutHelper.relativeHeight(percentOfScreen: 18))
            make.margins.equalTo(10)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        answerSectionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(LayoutHelper.relativeWidth(percentOfScreen: 80))
            make.height.equalTo(LayoutHelper.relativeHeight(percentOfScreen: 8))
            make.margins.equalTo(10)
        }
    }
    
    func loadAnswerFields() {
        var counter = 0
        for textfield in answerFields {
            stackView.addArrangedSubview(textfield)
            textfield.backgroundColor = .white
            textfield.text = "test"
            textfield.borderStyle = UITextField.BorderStyle.roundedRect
            textfield.delegate = self
            textfield.tag = counter
            stackView.addArrangedSubview(textfield)
            
            createConfigBucketButton(num: counter)
            counter += 1
//            stackView.setCustomSpacing(st, after: <#T##UIView#>)
            textfield.snp.makeConstraints { (make) in
                make.width.equalTo(LayoutHelper.relativeWidth(percentOfScreen: 80))
                make.height.equalTo(LayoutHelper.relativeHeight(percentOfScreen: 8))
                make.margins.equalTo(10)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    func reloadScreen() {
        if (currQuestionIndex > 0) {
            prevButton.isEnabled = true
            prevButton.alpha = 1.0
        } else if (currQuestionIndex == 0) {
            prevButton.isEnabled = false
            prevButton.alpha = 0.1
        }
        navigationItem.title = "Write Question \(currQuestionIndex + 1)"
        reloadFields()
    }
    
    func reloadFields() {
        let answers = quizManager.getAnswers(questionIndex: currQuestionIndex)
        for i in 0..<answers.count {
            answerFields[i].text = answers[i]
        }
        questionField.text = quizManager.getQuestionText(questionIndex: currQuestionIndex)
    }
    
    func createConfigBucketButton(num: Int) {
        let button = UIButton()
        button.setTitle("Configure Buckets", for: .normal)
        button.tag = num
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 20
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedBucketButton), for: .touchUpInside)
        stackView.addArrangedSubview(button)
        stackView.setCustomSpacing(20, after: button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(LayoutHelper.pixelRelativeToScreen(toWidth: 10))
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
        }
    }
    
    func saveQuestionAndAnswerFields() {
        let questionText = questionField.text ?? ""
        quizManager.saveQuestionText(questionIndex: currQuestionIndex, questionText: questionText)
        
        for textField in answerFields {
            let answerText = textField.text ?? ""
            quizManager.saveAnswer(questionIndex: currQuestionIndex, answerIndex: textField.tag, answerText: answerText)
        }
    }
    
    func loadFooterButtons() {
        prevButton.setTitle("Previous", for: .normal)
        prevButton.isEnabled = currQuestionIndex > 0
        prevButton.alpha = 0.1
        nextButton.setTitle("Next", for: .normal)
        prevButton.backgroundColor = .systemIndigo
        nextButton.backgroundColor = .systemTeal
        prevButton.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10
        prevButton.addTarget(self, action: #selector(tappedPrevButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        footorStack.axis = .horizontal
        footorStack.distribution = .fillEqually
        footorStack.spacing = 10
//        prevButton.snp.makeConstraints { (make) in
//            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
//        }
//        nextButton.snp.makeConstraints { (make) in
//            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
//        }
        footorStack.snp.makeConstraints { (make) in
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
        }
        footorStack.addArrangedSubview(prevButton)
        footorStack.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(footorStack)
    }
    
    func loadFinishCreationButton() {
        finishCreationButton.setTitle("Continue", for: . normal)
        finishCreationButton.backgroundColor = .systemGreen
        finishCreationButton.layer.cornerRadius = 10
        finishCreationButton.addTarget(self, action: #selector(tappedFinishCreationButton), for: .touchUpInside)
        finishCreationButton.snp.makeConstraints { (make) in
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
        }
        stackView.addArrangedSubview(finishCreationButton)
    }
    
    @objc func tappedBucketButton(_ sender: UIButton) {
        let configBucketVC = ConfigBucketController(quizManager: quizManager, answerIndex: sender.tag, questionIndex: currQuestionIndex)
        navigationController?.pushViewController(configBucketVC, animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let text = textView.text ?? ""
        quizManager.saveQuestionText(questionIndex: currQuestionIndex, questionText: text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        quizManager.saveAnswer(questionIndex: currQuestionIndex, answerIndex: textField.tag, answerText: text)
    }
    
    @objc func tappedPrevButton() {
        if (currQuestionIndex > 100) {
            return
        }
        currQuestionIndex -= 1
        reloadScreen()
    }
    
    @objc func tappedNextButton() {
        if (currQuestionIndex > 100) {
            return
        }
        saveQuestionAndAnswerFields()
        currQuestionIndex += 1
        quizManager.newQuestion()
        reloadScreen()
    }
    
    @objc func tappedFinishCreationButton() {
        //let db = Firebase.f
    }
    
}
