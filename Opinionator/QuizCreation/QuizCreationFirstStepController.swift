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
    
    var bucketFields = [UITextField(), UITextField()]
    
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
        print("DEBUG: quizcreationfirststepctonroller loaded")
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 10, left: 24, bottom: 0, right: 24)
        
        formContainerStackView.addArrangedSubview(imageBanner)
        formContainerStackView.addArrangedSubview(quizNameLabel)
        formContainerStackView.addArrangedSubview(quizNameField)
        formContainerStackView.addArrangedSubview(bucketSectionLabel)
        
        configureBucketFields()
        formContainerStackView.addArrangedSubview(addBucketButton)
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
    
    @objc func handleAddBucket() {
        print("DEBUG: ha ndle add bucket")
        print("debug: \(bucketFields.count)")
        let tf = UITextField()
        bucketFields.append(tf)
        tf.placeholder = "Enter bucket #\(bucketFields.count)"
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 20)
        tf.borderStyle = .roundedRect
        //formContainerStackView.addArrangedSubview(tf)
        formContainerStackView.insertSubview(tf, at: formContainerStackView.subviews.count - 2)
    }
    
    @objc func handleRemoveBucket() {
        
    }
}
