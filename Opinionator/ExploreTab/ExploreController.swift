//
//  ExploreController.swift
//  Opinionator
//
//  Created by Felix Yu on 10/19/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "quizCell"

class ExploreController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let userSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(handleSearchUsers), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    private let quizSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.borderWidth = 4
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(handleSearchQuizzes), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBlue
        navigationItem.title = "Search"
        
        let buttonStack = UIStackView(arrangedSubviews: [quizSearchButton, userSearchButton])
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 20
        userSearchButton.setTitle("Search For Users", for: .normal)
        quizSearchButton.setTitle("Search For Quizzes", for: .normal)
        view.addSubview(buttonStack)
        userSearchButton.widthAnchor.constraint(equalTo: buttonStack.widthAnchor).isActive = true
        buttonStack.centerYTo(view.centerYAnchor)
        buttonStack.centerXTo(view.centerXAnchor)
    }
    
    @objc func handleSearchUsers() {
        
    }
    
    @objc func handleSearchQuizzes() {
        let controller = QuizSearchController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(controller, animated: true)
    }
}
