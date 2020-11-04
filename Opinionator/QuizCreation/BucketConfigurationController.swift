//
//  BucketConfigurationController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/3/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class BucketConfigurationController: UIViewController {
    
    var bucketsData: [[[Double]]]
    var bucketNames: [String]
    var questionIndex: Int
    var answerIndex: Int
    let questionTitle: String
    let answerTitle: String
    
    lazy var sliders: [UISlider] = {
        //have to change 4 to bucketNames.count later
        var list = [UISlider]()
        for i in 0...3 {
            list.append(UISlider())
        }
        return list
    }()
    
    var scrollView = UIScrollView()
    
    var contentStack: UIStackView = {
        var stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()
    
    //todo will have to calculate height of the label and make it wrap around I think, if the question is too long
    lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Question: \(questionTitle)"
        return label
    }()
    
    lazy var answerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Answer: \(answerTitle)"
        return label
    }()
    
    init(questionIndex: Int, answerIndex: Int, bucketsData: [[[Double]]], bucketNames: [String], questionTitle: String, answerTitle: String) {
        self.bucketsData = bucketsData
        self.questionIndex = questionIndex
        self.answerIndex = answerIndex
        self.bucketNames = bucketNames
        self.questionTitle = questionTitle
        self.answerTitle = answerTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(scrollView)
//        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
//        scrollView.addSubview(contentStack)
//        contentStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
//
        view.addSubview(scrollView)
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        scrollView.addSubview(contentStack)
        contentStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        configureHeader()
        configureSliders()
    }
    
    func configureHeader() {
        contentStack.addArrangedSubview(questionTitleLabel)
        contentStack.addArrangedSubview(answerTitleLabel)
    }
    
    func configureSliders() {
        print("DEBUG \(sliders.count)")
        for (index, slider) in sliders.enumerated() {
            var label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 20)
            label.text = "Bucket: \(bucketNames[index])"
            
            sliders[index].minimumValue = -100
            sliders[index].maximumValue = 100
            sliders[index].addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
            sliders[index].isContinuous = true
            sliders[index].tag = index
            contentStack.addArrangedSubview(label)
            contentStack.addArrangedSubview(sliders[index])
        }
    }
    
    @objc func handleSliderChange(slider: UISlider) {
        print("DEBUG: handle slider change")
    }
}
