//
//  QuizResultController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/10/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class QuizResultController: UIViewController {
    
    var result: String
    var resultIndex: Int
    var quiz: QuizModel
    
    private lazy var resultImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let resultTextView = UITextView(frame: CGRect(x: 20, y: getTopSafeAreaHeight() + 70, width: UIScreen.main.bounds.width - 40, height: 200))
    
    private let timesTakenLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    init(result: String, resultIndex: Int, quiz: QuizModel) {
        self.result = result
        self.quiz = quiz
        self.resultIndex = resultIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.basicColors.teal
        navigationItem.title = "Results"
        resultImage.sd_setImage(with: quiz.bucketImageURLs[resultIndex], completed: nil)
        configureTextView()
        configureImage()
        configureFooter()
    }
    
    func configureImage() {
        
        view.addSubview(resultImage)
        resultImage.anchor(top: resultTextView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
        resultImage.withHeight(UIScreen.main.bounds.height / 3)
    }
    
    func configureTextView() {
        resultTextView.text = result
        resultTextView.font = UIFont.systemFont(ofSize: 30)
        resultTextView.textAlignment = .center
        resultTextView.textColor = .black
        resultTextView.backgroundColor = .white
        resultTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        resultTextView.layer.cornerRadius = 20
        resultTextView.centerVertically()
        view.addSubview(resultTextView)
    }
    
    func configureFooter() {
        timesTakenLabel.text = "Times taken: \(quiz.timesTaken)"
        view.addSubview(timesTakenLabel)
        timesTakenLabel.anchor(top: resultImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    }
    
    func updateInfo() {
        resultTextView.text = result
        timesTakenLabel.text = "Times taken: \(quiz.timesTaken)"
    }
    
}
