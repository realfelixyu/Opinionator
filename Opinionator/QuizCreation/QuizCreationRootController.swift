//
//  QuizCreationRootController.swift
//  Opinionator
//
//  Created by Felix Yu on 8/22/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields

class QuizCreationRootController: UIViewController, UITextFieldDelegate {
    var quizName = UITextField()
    var continueButton = UIButton()
    var quizManager = QuizCreationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadQuestionTextField()
        loadContinueButton()
    }
    
    func loadQuestionTextField() {
        quizName.placeholder = "Type Quiz Name"
        quizName.borderStyle = UITextField.BorderStyle.bezel
        quizName.delegate = self
        view.addSubview(quizName)
        quizName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
        }
    }
    
    func loadContinueButton() {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor.basicColors.teal
        continueButton.layer.cornerRadius = 5
        //continueButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        continueButton.addTarget(self, action: #selector(tappedContinueButton), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(quizName.snp.top).offset(LayoutHelper.pixelRelativeToScreen(toHeight: 100))
            make.width.equalTo(LayoutHelper.pixelRelativeToScreen(toWidth: 200))
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 50))
        }
    }
    
    @objc func tappedContinueButton(sender: UIButton!) {
        let bucketVC = BucketSelectionController(quizManager: quizManager)
        navigationController?.pushViewController(bucketVC, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        quizManager.saveName(name: textField.text!)
    }
}
