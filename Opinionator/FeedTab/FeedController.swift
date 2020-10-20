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

class FeedController: UIViewController {
    
    var user: User? {
        didSet{
            configureUI()
            configureLeftBarButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "Home"
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
    
    @objc func handleProfileImageTap() {
        
    }
}
