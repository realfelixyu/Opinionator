//
//  QuizCell.swift
//  Opinionator
//
//  Created by Felix Yu on 11/6/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

protocol QuizCellDelegate: class {
    func handleGoToUserProfile(_ cell: QuizCell)
}

class QuizCell: UICollectionViewCell {
    
    var quiz: QuizModel? {
        didSet {
             configure()
        }
    }
    
    weak var delegate: QuizCellDelegate?
    
    private lazy var quizTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var creatorUsernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 25)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        let creatorInfoStack = UIStackView(arrangedSubviews: [profileImageView, creatorUsernameLabel])
        creatorInfoStack.distribution = .fillProportionally
        creatorInfoStack.spacing = 10
        creatorInfoStack.axis = .horizontal
        
        contentView.addSubview(creatorInfoStack)
        creatorInfoStack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 5)
        
        contentView.addSubview(quizTitleLabel)
        quizTitleLabel.anchor(top: creatorInfoStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let quiz = quiz else { return }

        
//        var testLabel = UILabel()
//        testLabel.text = "Test"
//        testLabel.font = UIFont.systemFont(ofSize: 40)
//        testLabel.backgroundColor = .black
//
//
//        contentView.addSubview(testLabel)
        let viewModel = QuizCellViewModel(quiz: quiz)
        //profileImageView.sd_setImage(with: viewModel.profileImageURL, completed: nil)
        profileImageView.image = #imageLiteral(resourceName: "icons8-user-96")
        print("DEBUG: \(quiz.title)")
        creatorUsernameLabel.text = quiz.creator.username
        quizTitleLabel.text = quiz.title
    }
    
    @objc func handleGoToUserProfile() {
        delegate?.handleGoToUserProfile(self)
    }
}
