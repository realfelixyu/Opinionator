//
//  ConfigBucketController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/31/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class ConfigBucketController: UIViewController {
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var sliders = [UISlider]()
    var quizManager: QuizCreationManager
    var answerIndex: Int
    var questionIndex: Int
    
    init(quizManager: QuizCreationManager, answerIndex: Int, questionIndex: Int) {
        self.quizManager = quizManager
        self.answerIndex = answerIndex
        self.questionIndex = questionIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScrollView()
        loadStackView()
        loadBucketSection()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if self.isMovingFromParent {
            let points = sliders.map { $0.value }
            quizManager.saveBucketPoints(questionIndex: questionIndex, answerIndex: answerIndex, points: points)
        }
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
        navigationItem.title = "Bucket Points"
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
    }
    
    func loadBucketSection() {
        let bucketList = quizManager.getBuckets()
        let points = quizManager.getBucketPoints(questionIndex: questionIndex, answerIndex: answerIndex)
        for i in 0..<bucketList.count {
            let label = UILabel()
            label.text = bucketList[i]
            let slider = UISlider()
            sliders.append(slider)
            //slider.addTarget(self, action: #selector(sliderMoved), for: .allEditingEvents)
            slider.tag = i
            slider.maximumValue = 100.0
            slider.minimumValue = -100.0
            slider.value = points[i]
            stackView.addArrangedSubview(label)
            stackView.addArrangedSubview(slider)
        }
    }
    
    @objc func sliderMoved(_ sender: UISlider) {

    }
}
