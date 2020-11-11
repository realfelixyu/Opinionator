//
//  QuizInfoController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/8/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class QuizInfoController: UIViewController {
    
    var quiz: QuizModel
    
    private lazy var byLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 32, height: 32)
        iv.layer.cornerRadius = 32 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private lazy var quizTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 35)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var takeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Take Quiz", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(handleTakeQuiz), for: .touchUpInside)
        return button
    }()
    
    init(quiz: QuizModel) {
        self.quiz = quiz
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        quizTitleLabel.text = quiz.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeader()
        configureBody()
    }
    
    func configureHeader() {
        view.addSubview(quizTitleLabel)
        quizTitleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 15)
        let creatorStack = UIStackView(arrangedSubviews: [byLabel, profileImageView])
        creatorStack.spacing = 12
        creatorStack.axis = .horizontal
        creatorStack.distribution = .fillProportionally
        creatorStack.alignment = .trailing
        profileImageView.image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        byLabel.text = "By \(quiz.creator.username)"
        view.addSubview(creatorStack)
        creatorStack.anchor(top: quizTitleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 12, paddingRight: 20)
    }
    
    func configureBody() {
        view.addSubview(takeButton)
        takeButton.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 50, paddingRight: 50)
        takeButton.centerX(inView: view)
    }
    
    @objc func handleTakeQuiz() {
        let controller = QuizController(quiz: quiz)
        navigationController?.pushViewController(controller, animated: true)
    }
}
