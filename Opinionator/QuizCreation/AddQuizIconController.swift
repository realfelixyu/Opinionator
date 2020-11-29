//
//  AddQuizIconController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/15/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit

class AddQuizIconController: UIViewController {
    
    var quizName: String
    var bucketNames: [String]
    var bucketImages: [UIImage]
    var bucketImageIndexs: [Int]
    var imagePicker = UIImagePickerController()
    var quizIcon: UIImage?
    
    var addImageButton: UIButton = {
        var button = UIButton()
        button.setTitle("Add Icon", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 2
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Add an icon to your quiz?"
        return label
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.basicColors.teal
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    init(quizName: String, bucketNames: [String], bucketImages: [UIImage], bucketImageIndexs: [Int]) {
        self.quizName = quizName
        self.bucketNames = bucketNames
        self.bucketImages = bucketImages
        self.bucketImageIndexs = bucketImageIndexs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 60, paddingLeft: 20, paddingRight: 20)
        view.addSubview(addImageButton)
        addImageButton.setDimensions(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.width - 40)
        addImageButton.anchor(top: titleLabel.bottomAnchor, paddingTop: 25)
        addImageButton.centerX(inView: view)
        view.addSubview(nextButton)
        nextButton.anchor(top: addImageButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    }
    
    @objc func showImagePicker() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleNext() {
        let controller = QuestionCreationController(quizName: quizName, bucketNames: bucketNames, bucketImages: bucketImages, bucketImageIndexs: bucketImageIndexs, quizIcon: quizIcon)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension AddQuizIconController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let iconImage = info[.editedImage] as? UIImage else { return }
        addImageButton.setImage(iconImage.withRenderingMode(.alwaysOriginal), for: .normal)
//
//        plusPhotoButton.layer.cornerRadius = 128/2
//        plusPhotoButton.layer.masksToBounds = true
//        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
//        plusPhotoButton.imageView?.clipsToBounds = true
//        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
//        plusPhotoButton.layer.borderWidth = 3
//        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
//
        print("DEBUG: should be calling dismiss")
        dismiss(animated: true, completion: nil)
    }
}
