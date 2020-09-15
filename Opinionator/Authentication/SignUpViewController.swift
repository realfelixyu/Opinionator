//
//  SignUpViewController.swift
//  Opinionator
//
//  Created by Felix Yu on 9/14/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var stackView = UIStackView()
    var nickNameField = UITextField()
    var emailField = UITextField()
    var passwordField = UITextField()
    var errorLabel = UILabel()
    var submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStackView()
        loadNickNameField()
        loadEmailField()
        loadPasswordField()
        loadErrorLabel()
        loadSubmitButton()
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 200))
            make.centerY.equalToSuperview()
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        stackView.spacing = 10;
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    func loadStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(submitButton)
        view.addSubview(stackView)
    }
    
    func loadNickNameField() {
        nickNameField.placeholder = "Nickname - Changable later"
    }
    
    func loadEmailField() {
        emailField.placeholder = "Email"
    }
    
    func loadPasswordField() {
        passwordField.placeholder = "Password"
    }
    
    func loadErrorLabel() {
        
    }
    
    func loadSubmitButton() {
        submitButton.setTitle("Sign Up", for: .normal)
    }
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "hand.point.left.fill")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .blue
        backButton.setTitle("  Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return backButton
    }

    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}
