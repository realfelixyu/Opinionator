//
//  FeedController.swift
//  Opinionator
//
//  Created by Felix Yu on 10/19/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

private let reuseIdentifier = "quizCell"

class FeedController: UICollectionViewController {
    
    var user: User? {
        didSet{
            configureLeftBarButton()
            fetchQuizzes()
        }
    }
    
    private var quizzes = [QuizModel]() {
        didSet {
            collectionView.reloadData()
            print("DEBUG: quizzes set in feedcontroller size: \(quizzes.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        collectionView.backgroundColor = .white
        navigationItem.title = "Home"
        
        collectionView.register(QuizCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    func configureLeftBarButton() {
        guard let user = user else {return}
        let profileImageView = UIImageView()
        
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
        profileImageView.addGestureRecognizer(tap)
        
        if user.profileImageUrl != nil {
            profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        } else {
            profileImageView.image = #imageLiteral(resourceName: "icons8-user-96")
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    func fetchQuizzes() {
        QuizCreationService.shared.fetchQuizzes { (quizzes) in
            self.quizzes = quizzes
            print("DEBUG: quizzes fetched")
        }
    }
    
    @objc func handleProfileImageTap() {
        
    }
}

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuizCell
        cell.quiz = quizzes[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = QuizInfoController(quiz: quizzes[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: 200)
    }
    
}


