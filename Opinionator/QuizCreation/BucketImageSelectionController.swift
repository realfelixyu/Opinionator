//
//  BucketImageSelectionController.swift
//  Opinionator
//
//  Created by Felix Yu on 11/12/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import LBTATools

class BucketImageSelectionController: LBTAFormController {
    
    var quizName: String
    var bucketNames: [String]
    var imagePicker = UIImagePickerController()
    var bucketLabels = [UILabel]()
    var bucketAddImageButtons = [UIButton]()
    //index of the image/button
    var imageFlag = 0
    var imagesMap = [Int: UIImage]()
    
    private var quizNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private var guideLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.basicColors.teal
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(quizName: String, bucketNames: [String]) {
        self.quizName = quizName
        self.bucketNames = bucketNames
        for (index, name) in bucketNames.enumerated() {
            bucketLabels.append(UILabel())
            bucketAddImageButtons.append(UIButton())
        }
        //wtf why do we have to call super.init after setting quizName?
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formContainerStackView.backgroundColor = .white
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 10, left: 24, bottom: 0, right: 24)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        navigationItem.title = "Images for buckets"
        
        configureHeader()
        configureLabelsAndButtons()
        
        formContainerStackView.addArrangedSubview(nextButton)
    }
    
    func configureHeader() {
        quizNameLabel.text = quizName
        formContainerStackView.addArrangedSubview(quizNameLabel)
        guideLabel.text = "Tip: Users will see the corresponding pictures for their resulting bucket"
        formContainerStackView.addArrangedSubview(guideLabel)
    }
    
    func configureLabelsAndButtons() {
        for (index, label) in bucketLabels.enumerated() {
            let stack = UIStackView(arrangedSubviews: [label, bucketAddImageButtons[index]])
            stack.axis = .vertical
            stack.distribution = .fill
            label.textColor = .darkGray
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.textAlignment = .center
            label.text = "\(bucketNames[index])"
            bucketAddImageButtons[index].tag = index
            bucketAddImageButtons[index].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
            bucketAddImageButtons[index].heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3).isActive = true
            bucketAddImageButtons[index].setTitle("Add Photo", for: .normal)
            bucketAddImageButtons[index].layer.borderColor = UIColor.twitterBlue.cgColor
            bucketAddImageButtons[index].layer.borderWidth = 1.25
            bucketAddImageButtons[index].setTitleColor(.twitterBlue, for: .normal)
            bucketAddImageButtons[index].titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            bucketAddImageButtons[index].addTarget(self, action: #selector(handleImagePickerTapped), for: .touchUpInside)
            formContainerStackView.addArrangedSubview(stack)
        }
    }
    
    @objc func handleImagePickerTapped(button: UIButton) {
        imageFlag = button.tag
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func nextButtonTapped() {
        var bucketImages = [UIImage]()
        var bucketImageIndexs = [Int]()
        for (index, image) in imagesMap {
            bucketImages.append(image)
            bucketImageIndexs.append(index)
        }
        let controller = AddQuizIconController(quizName: quizName, bucketNames: bucketNames, bucketImages: bucketImages, bucketImageIndexs: bucketImageIndexs)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension BucketImageSelectionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        bucketAddImageButtons[imageFlag].setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        imagesMap[imageFlag] = profileImage
//
//        plusPhotoButton.layer.cornerRadius = 128/2
//        plusPhotoButton.layer.masksToBounds = true
//        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
//        plusPhotoButton.imageView?.clipsToBounds = true
//        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
//        plusPhotoButton.layer.borderWidth = 3
//        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
//
        dismiss(animated: true, completion: nil)
    }
}
