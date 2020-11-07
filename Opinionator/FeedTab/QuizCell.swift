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
    
    private lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = quiz?.title
        return label
    }()
    
    private lazy var creatorUsernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = quiz?.creator.username
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
        
        backgroundColor = .white
        let creatorInfoStack = UIStackView(arrangedSubviews: [creatorUsernameLabel, profileImageView])
        creatorInfoStack.distribution = .fillProportionally
        creatorInfoStack.spacing = 12
        creatorInfoStack.axis = .horizontal
        contentView.addSubview(creatorInfoStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let quiz = quiz else { return }
        let viewModel = QuizCellViewModel(quiz: quiz)
        //profileImageView.sd_setImage(with: viewModel.profileImageURL, completed: nil)
        profileImageView.image = #imageLiteral(resourceName: "icons8-user-96")
    }
    
    @objc func handleGoToUserProfile() {
        delegate?.handleGoToUserProfile(self)
    }
}
