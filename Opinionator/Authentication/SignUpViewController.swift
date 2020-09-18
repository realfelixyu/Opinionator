//
//  SignUpViewController.swift
//  Opinionator
//
//  Created by Felix Yu on 9/14/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

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
        view.addSubview(errorLabel)
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
        submitButton.setTitle("Sign Up", for: .normal)
        submitButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        submitButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(50)
            //make.top.equalTo(stackView.snp_bottomMargin)
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
    
    @objc func signUpTapped(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            let nickName = nickNameField.text!.trimmingCharacters(in: .newlines)
            let email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "nickname": nickName,
                        "newUser": "true",
                        "uid": result!.user.uid
                    ]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    self.transitionToHome()
                }
            }
            
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    //check signup fields that the dat ais correct. Returns nil if everything is correct, else return error
    func validateFields() -> String? {
        if nickNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if AuthUtilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is atleast 8 characters. contains a special character and a number."
        }
        
        if (passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != passwordAgainField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) {
            return "Please make sure your passwords match"
        }
        
        return nil
    }
    
    func transitionToHome() {
        let appVC = TabBarController()
        view.window?.rootViewController = appVC
        //navigationController?.pushViewController(appVC, animated: true)
    }

}
