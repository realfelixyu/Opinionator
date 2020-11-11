//
//  BucketConfigurationController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/3/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

protocol BucketDataSaver {
    func saveData(data: [Float], answerIndex: Int)
}

class BucketConfigurationController: UIViewController {
    
    var data: [Float]
    var bucketNames: [String]
    var answerIndex: Int
    let questionTitle: String
    let answerTitle: String
    var delegate: BucketDataSaver?
    
    lazy var sliders: [UISlider] = {
        //have to change 4 to bucketNames.count later
        var list = [UISlider]()
        for i in 0..<bucketNames.count {
            list.append(UISlider())
        }
        return list
    }()
    
    lazy var sliderLabels: [UILabel] = {
        var list = [UILabel]()
        for i in 0..<bucketNames.count {
            list.append(UILabel())
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
    
    init(data: [Float], answerIndex: Int, bucketNames: [String], questionTitle: String, answerTitle: String) {
        self.answerIndex = answerIndex
        self.data = data
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
    
    override func viewWillDisappear(_ animated: Bool) {
        for i in 0..<bucketNames.count {
            // usinng double to store float, should maybe be changed later.
            data[i] = sliders[i].value
            //print("DEBUG: \(sliders[i].value)")
        }
        delegate?.saveData(data: data, answerIndex: answerIndex)
    }
    
    func configureHeader() {
        contentStack.addArrangedSubview(questionTitleLabel)
        contentStack.addArrangedSubview(answerTitleLabel)
    }
    
    func configureSliders() {
        //print("DEBUG \(sliders.count)")
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
            sliders[index].value = data[index]
            
            sliderLabels[index].text = String(sliders[index].value)
            sliderLabels[index].font = UIFont.systemFont(ofSize: 18)
            sliderLabels[index].textColor = .black
            sliderLabels[index].textAlignment = .center
            
            contentStack.addArrangedSubview(label)
            contentStack.addArrangedSubview(sliderLabels[index])
            contentStack.addArrangedSubview(sliders[index])
        }
    }
    
    @objc func handleSliderChange(slider: UISlider) {
        print("DEBUG: handle slider change")
        sliderLabels[slider.tag].text = String(slider.value)
    }
}
