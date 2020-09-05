//
//  QuestionAnswerController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/30/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class QuestionAnswerController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var questionNumLabel = UILabel()
    var answerSectionLabel = UILabel()
    var questionField = UITextView()
    var answerFields = [UITextField(), UITextField(),UITextField(),UITextField()]
    var scrollView = UIScrollView()
    var prevButton = UIButton()
    var nextButton = UIButton()
    var footorStack = UIStackView()
    var stackView = UIStackView()
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
        loadScrollView()
        loadStackView()
        loadFooterButtons()
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
        navigationItem.title = "Write Question"
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
        questionNumLabel.text = "Question \(currQuestionIndex + 1):"
        questionField.backgroundColor = .gray
        questionField.text = "test"
        questionField.font = UIFont.systemFont(ofSize: 20)
        questionField.layer.cornerRadius = 5
        questionField.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        answerSectionLabel.text = "Answers"
        answerSectionLabel.font = UIFont.systemFont(ofSize: 20)
        
        stackView.addArrangedSubview(questionNumLabel)
        stackView.addArrangedSubview(questionField)
        stackView.addArrangedSubview(answerSectionLabel)

        questionNumLabel.snp.makeConstraints { (make) in
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
            
            createButton(num: counter)
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
    
    func createButton(num: Int) {
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
    
    func loadFooterButtons() {
        prevButton.setTitle("Previous", for: .normal)
        nextButton.setTitle("Next", for: .normal)
        prevButton.backgroundColor = .systemIndigo
        nextButton.backgroundColor = .systemGreen
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
    
    @objc func tappedBucketButton(_ sender: UIButton) {
        let configBucketVC = ConfigBucketController(quizManager: quizManager, answerIndex: sender.tag)
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
        
    }
    
    @objc func tappedNextButton() {
        
    }
    
}
