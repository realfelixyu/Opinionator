//
//  LoginViewController.swift
//  Opinionator
//
//  Created by Felix Yu on 9/14/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var stackView = UIStackView()
    var loginLabel = UILabel()
    var emailField = UITextField()
    var passwordField = UITextField()
    var submitButton = UIButton()
    var backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStackView()
        loadEmailField()
        loadPasswordField()
        loadSubmitButton()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        view.backgroundColor = .systemTeal
        // Do any additional setup after loading the view.
    }
    
    func loadStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(loginLabel)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(submitButton)
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 400))
            make.centerY.equalToSuperview()
        }
        stackView.spacing = 10;
        view.addSubview(stackView)
    }
    
    func loadLoginLabel() {
        loginLabel.text = "Login"
        loginLabel.textColor = .black
        loginLabel.heightAnchor.constraint(equalToConstant: LayoutHelper.pixelRelativeToScreen(toHeight: 50))
    }
    
    func loadEmailField() {
        emailField.placeholder = "Email"
        emailField.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }
    }
    
    func loadPasswordField() {
        passwordField.placeholder = "Password"
    }
    
    func loadSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Login", for: .normal)
        submitButton.backgroundColor = .systemGreen
        submitButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        submitButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        
    }

}
