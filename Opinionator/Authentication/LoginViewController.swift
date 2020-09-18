//
//  LoginViewController.swift
//  Opinionator
//
//  Created by Felix Yu on 9/14/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    
    var stackView = UIStackView()
    var loginLabel = UILabel()
    var emailField = UITextField()
    var passwordField = UITextField()
    var errorLabel = UILabel()
    var submitButton = UIButton()
    var backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStackView()
        loadEmailField()
        loadPasswordField()
        loadErrorLabel()
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
        view.addSubview(errorLabel)
        view.addSubview(submitButton)
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
        styleField(emailField)
    }
    
    func loadPasswordField() {
        passwordField.placeholder = "Password"
        styleField(passwordField)
    }
    
    func loadErrorLabel() {
        errorLabel.alpha = 0
        errorLabel.text = ""
        errorLabel.textColor = .red
        errorLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        errorLabel.numberOfLines = 3
        errorLabel.textAlignment = .center
        errorLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-100)
//            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(10)
        }
    }
    
    func loadSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Login", for: .normal)
        submitButton.backgroundColor = .systemGreen
        submitButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(50)
            //make.top.equalTo(stackView.snp_bottomMargin)
            make.width.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
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
    
    func styleField(_ textField: UITextField) {
        //textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        textField.minimumFontSize = LayoutHelper.fontRelativeToScreen(toSize: 10)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }

    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if (email == nil || password == nil) {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.showError(err!.localizedDescription)
            } else {
                self.transitionToHome()
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let appVC = TabBarController()
        view.window?.rootViewController = appVC
    }

}
