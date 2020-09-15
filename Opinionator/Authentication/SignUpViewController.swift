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
    var passwordAgainField = UITextField()
    var errorLabel = UILabel()
    var submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStackView()
        loadNickNameField()
        loadEmailField()
        loadPasswordFields()
        loadErrorLabel()
        loadSubmitButton()
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(75)
            make.bottom.equalToSuperview().offset(-150)
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        //stackView.spacing = 20;
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    func loadStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(nickNameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(passwordAgainField)
        //stackView.addArrangedSubview(errorLabel)
        view.addSubview(stackView)
        view.addSubview(submitButton)
    }
    
    func loadNickNameField() {
        nickNameField.placeholder = "Nickname - Changable later"
        //nickNameField.setBottomBorder()
        nickNameField.addShadowToTextField(cornerRadius: 10)
        nickNameField.autocapitalizationType = .none
        nickNameField.autocorrectionType = .no
        styleField(nickNameField)
    }
    
    func loadEmailField() {
        emailField.placeholder = "Email"
        styleField(emailField)
    }
    
    func loadPasswordFields() {
        passwordField.placeholder = "Password"
        passwordAgainField.placeholder = "Password again"
        styleField(passwordField)
        styleField(passwordAgainField)
    }
    
    func loadErrorLabel() {
        
    }
    
    func loadSubmitButton() {
        submitButton.setTitle("Sign Up", for: .normal)
        submitButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(50)
            make.top.equalTo(stackView.snp_bottomMargin)
            make.width.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        submitButton.backgroundColor = .systemBlue
        print(submitButton.frame.width)
        print(submitButton.frame.height)
    }
    
    func styleField(_ textField: UITextField) {
        //textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        textField.minimumFontSize = LayoutHelper.fontRelativeToScreen(toSize: 10)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .blue
        backButton.setTitle(" Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return backButton
    }

    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}
