//
//  CreationTabController.swift
//  Opinionator
//
//  Created by Felix Yu on 10/19/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class CreationTabController: UIViewController {
    
    lazy var bucketSectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Configure Your Buckets: "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var quizNameFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Quiz Name: "
        return label
    }()
    
    lazy var quizNameField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.textColor = .twitterBlue
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.placeholder = "Enter Quiz Name"
        return tf
    }()
    
    var creationImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "plumber.png"))
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: view.bounds)
        return sv
    }()
    
    var buckets = [UITextField(), UITextField()]
    
    var addBucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Bucket", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleAddBucket), for: .touchUpInside)
        return button
    }()
    
    var removeBucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove Bucket", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleRemoveBucket), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "Create"
        
        scrollView.contentInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20)
        creationImage.setDimensions(width: view.frame.width, height: 200)
        scrollView.addSubview(creationImage)
        creationImage.centerX(inView: scrollView)
//        creationImage.centerX(inView: view)
//        creationImage.anchor(top: view.topAnchor, paddingTop: 150)
        
        configureQuizNameStack()
//        configureBucketSection()
//        configureFooterButtons()
        view.addSubview(scrollView)
    }
    
    func configureQuizNameStack() {
        let quizNameStack = UIStackView(arrangedSubviews: [quizNameFieldLabel, quizNameField])
        quizNameStack.translatesAutoresizingMaskIntoConstraints = false
        quizNameStack.axis = .vertical
        //quizNameStack.distribution = .fillProportionally
        quizNameStack.spacing = 4
        scrollView.addSubview(quizNameStack)
        //quizNameStack.anchor(top: creationImage.bottomAnchor, left: view.leftAnchor, paddingTop: 50, paddingLeft: 50)
    }
    
    func configureBucketSection() {
        view.addSubview(bucketSectionLabel)
        bucketSectionLabel.anchor(top: quizNameField.bottomAnchor, left: view.leftAnchor, paddingTop: 50, paddingLeft: 50)
        
        for (index, tf) in buckets.enumerated(){
            view.addSubview(tf)
            if (index == 0) {
                tf.anchor(top: bucketSectionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingRight: 30)
            } else {
                tf.anchor(top: buckets[index - 1].bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 30, paddingRight: 30)
            }
            tf.placeholder = "Enter bucket #\(index + 1)"
            tf.textColor = .black
            tf.font = UIFont.systemFont(ofSize: 18)
            tf.borderStyle = .roundedRect
        }
    }
    
    func configureFooterButtons() {
        view.addSubview(addBucketButton)
        addBucketButton.anchor(top: buckets[buckets.count - 1].bottomAnchor, paddingTop: 50)
        view.addSubview(removeBucketButton)
        removeBucketButton.anchor(top: addBucketButton.bottomAnchor, paddingTop: 200)
    }
    
    @objc func handleAddBucket() {
        print("DEBUG: handle add bucket")
    }
    
    @objc func handleRemoveBucket() {
        print("DEBUG: handle remove bucket")
    }

}

