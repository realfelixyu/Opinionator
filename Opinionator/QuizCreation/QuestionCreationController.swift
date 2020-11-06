//
//  QuestionCreationController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/3/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import UIKit
import Foundation



class QuestionCreationController: UIViewController {
    
    var answerFields = [UITextField(), UITextField(), UITextField(), UITextField()]
    var configureButtons = [UIButton(), UIButton(), UIButton(), UIButton()]
    var currQuestionIndex = 0;
    
    var quizName: String
    var bucketNames: [String]
    var questionTitlesData = [String]()
    var answersData = [[String]]()
    var bucketsData = [[[Float]]]()
    
    var imageBanner: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "plumber.png"))
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 100, height: 100)
        return iv
    }()
    
    var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        return scrollView
    }()
    
    var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()
    
    lazy var questionNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Question Number: \(currQuestionIndex + 1)"
        return label
    }()
    
    var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Question Title: "
        return label
    }()
    
    var questionTitleField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.textColor = .twitterBlue
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.placeholder = "Enter Question"
        tf.autocorrectionType = .no
        return tf
    }()
    
    var prevButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Previous Question", for: .normal)
            button.layer.borderColor = UIColor.twitterBlue.cgColor
            button.layer.borderWidth = 1.25
            button.setTitleColor(.twitterBlue, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            button.addTarget(self, action: #selector(handlePreviousQuestion), for: .touchUpInside)
            return button
    }()
    
    var nextButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Next Question", for: .normal)
            button.layer.borderColor = UIColor.twitterBlue.cgColor
            button.layer.borderWidth = 1.25
            button.setTitleColor(.twitterBlue, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            button.addTarget(self, action: #selector(handleNextQuestion), for: .touchUpInside)
            return button
    }()
    
    var submitButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Finish", for: .normal)
            button.layer.borderColor = UIColor.twitterBlue.cgColor
            button.layer.borderWidth = 1.25
            button.setTitleColor(.twitterBlue, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
            button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
            return button
    }()
    
    init(quizName: String, bucketNames: [String]) {
        self.quizName = quizName
        self.bucketNames = bucketNames
        //wtf why do we have to call super.init after setting quizName?
        print("DEBUG: \(quizName)")
        print("DEBUG: \(bucketNames)")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("DEBUG: somethin")
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        scrollView.addSubview(contentStack)
        contentStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: contentStack.bounds.height + 100)

        configureHeader()
        configureQuestionFields()
        configureFooter()
        addDefaultBucketValues()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
//    }
    
    func configureHeader() {
        contentStack.addArrangedSubview(questionNumLabel)
        contentStack.addArrangedSubview(questionLabel)
        contentStack.addArrangedSubview(questionTitleField)
    }
    
    func configureQuestionFields() {
        for (index, field) in answerFields.enumerated() {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18)
            label.text = "Answer Option \(index + 1)"
            let stack = UIStackView(arrangedSubviews: [label, configureButtons[index]])
            stack.distribution = .fillProportionally
            stack.axis = .horizontal
            stack.spacing = 10
            configureButtons[index].setTitle("Set Buckets", for: .normal)
            configureButtons[index].layer.borderColor = UIColor.twitterBlue.cgColor
            configureButtons[index].layer.borderWidth = 1.25
            configureButtons[index].setTitleColor(.twitterBlue, for: .normal)
            configureButtons[index].titleLabel?.font = UIFont.systemFont(ofSize: 20)
            configureButtons[index].addTarget(self, action: #selector(handleConfigureBucket), for: .touchUpInside)
            configureButtons[index].layer.cornerRadius = 15
            configureButtons[index].tag = index
            contentStack.addArrangedSubview(stack)
            
            field.placeholder = "Enter answer option"
            field.textAlignment = .left
            field.textColor = .twitterBlue
            field.borderStyle = .roundedRect
            field.font = UIFont.systemFont(ofSize: 20)
            contentStack.addArrangedSubview(field)
        }
    }
    
    func configureFooter() {
        contentStack.addArrangedSubview(nextButton)
        contentStack.addArrangedSubview(prevButton)
        prevButton.isEnabled = false
        contentStack.addArrangedSubview(submitButton)
    }
    
    // add default bucket values(0.0) for a new question with 4 answer choices
    func addDefaultBucketValues() {
        var newBucketData = [[Float]]()
        for i in (0..<4) {
            var list = [Float](repeating: 0.0, count: bucketNames.count)
            newBucketData.append(list)
        }
        var newAnswerData = [String](repeating: "", count: 4)
        bucketsData.append(newBucketData)
        answersData.append(newAnswerData)
        questionTitlesData.append("")
    }
    
    @objc func handleNextQuestion() {
        if (currQuestionIndex >= questionTitlesData.count) {
            questionTitlesData.append(questionLabel.text ?? "")
        } else {
            questionTitlesData[currQuestionIndex] = questionLabel.text ?? ""
        }
        for i in 0..<4 {
            answersData[currQuestionIndex][i] = answerFields[i].text ?? ""
        }
        //next question data
        currQuestionIndex += 1
        if (questionTitlesData.count <= currQuestionIndex) {
            addDefaultBucketValues()
        }
        //display new data on view
        for i in 0..<4 {
            answerFields[i].text = answersData[currQuestionIndex][i]
        }
        questionTitleField.text = questionTitlesData[currQuestionIndex]
        questionNumLabel.text = "Question Number: \(currQuestionIndex + 1)"
        
        prevButton.isEnabled = currQuestionIndex > 0
    }
    
    @objc func handlePreviousQuestion() {
        print("DEBUG: handle previous question")
    }
    
    @objc func handleSubmit() {
        
    }
    
    @objc func handleConfigureBucket(button: UIButton) {
        let controller = BucketConfigurationController(data: bucketsData[currQuestionIndex][button.tag], answerIndex: button.tag, bucketNames: bucketNames, questionTitle: questionTitleField.text ?? "Empty question title", answerTitle: answerFields[button.tag].text ?? "Unwritten answer option")
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension QuestionCreationController: BucketDataSaver {
    func saveData(data: [Float], answerIndex: Int) {
        bucketsData[currQuestionIndex][answerIndex] = data
    }
}
