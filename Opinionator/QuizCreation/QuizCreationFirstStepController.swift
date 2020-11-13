//
//  QuizCreationFirstStepController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/3/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import LBTATools

class QuizCreationFirstStepController: LBTAFormController {
    var imageBanner: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "plumber.png"))
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.constrainWidth(100)
        iv.constrainHeight(200)
        return iv
    }()
    
    var quizNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Quiz Name: "
        return label
    }()
    
    var quizNameField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .left
        tf.textColor = .twitterBlue
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 24)
        tf.placeholder = "Enter Quiz Name"
        return tf
    }()
    
    var bucketSectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Configure Your Buckets: "
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var bucketFields = [UITextField(), UITextField(), UITextField(), UITextField()]
    
    var addBucketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Bucket", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.addTarget(self, action: #selector(handleAddBucket), for: .touchUpInside)
        return button
    }()
    
    var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 20
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView.alwaysBounceVertical = true
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 10, left: 24, bottom: 0, right: 24)
        
        formContainerStackView.addArrangedSubview(imageBanner)
        formContainerStackView.addArrangedSubview(quizNameLabel)
        formContainerStackView.addArrangedSubview(quizNameField)
        formContainerStackView.addArrangedSubview(bucketSectionLabel)
        
        configureBucketFields()
        formContainerStackView.addArrangedSubview(addBucketButton)
        formContainerStackView.addArrangedSubview(continueButton)
    }
    
    func configureBucketFields() {
        for (index, tf) in bucketFields.enumerated() {
            formContainerStackView.addArrangedSubview(tf)
            tf.placeholder = "Enter bucket #\(index + 1)"
            tf.textColor = .black
            tf.font = UIFont.systemFont(ofSize: 20)
            tf.borderStyle = .roundedRect
        }
    }
//
    @objc func handleAddBucket() {
        print("DEBUG: handle add bucket")
        print("debug: \(bucketFields.count)")
        let tf = UITextField()
        bucketFields.append(tf)
        tf.placeholder = "Enter bucket #\(bucketFields.count)"
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.borderStyle = .roundedRect
        //formContainerStackView.addArrangedSubview(tf)
        formContainerStackView.insertArrangedSubview(tf, at: formContainerStackView.subviews.count - 2)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: formContainerStackView.bounds.height + 100)
    }
    
    @objc func handleRemoveBucket() {
        
    }
    
    @objc func handleContinue() {
        var bucketNames = [String]()
        for bucket in bucketFields {
            if let text = bucket.text {
                if text != "" {
                    bucketNames.append(text)
                }
            }
        }
        let controller = BucketImageSelectionController(quizName: quizNameField.text ?? "No quiz name", bucketNames: bucketNames)
        navigationController?.pushViewController(controller, animated: true)
    }
}
