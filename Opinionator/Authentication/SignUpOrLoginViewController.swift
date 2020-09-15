//
//  SignUpOrLoginViewController.swift
//  Opinionator
//
//  Created by Felix Yu on 9/14/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import UIKit

class SignUpOrLoginViewController: ViewController {
    
    var stackView = UIStackView()
    var signUpButton = UIButton();
    var loginButton = UIButton();

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStack()
        loadSignUpButton()
        loadLoginButton()
        // Do any additional setup after loading the view.
    }
    
    func loadStack() {
        stackView.axis = .vertical
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(signUpButton)
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview();
//            make.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(LayoutHelper.pixelRelativeToScreen(toHeight: 200))
            make.centerY.equalToSuperview()
        }
        stackView.spacing = 10;
        view.backgroundColor = .white
    }
    
    func loadSignUpButton() {
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .green
        signUpButton.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
    }
    
    func loadLoginButton() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
    }
    
    @objc func tappedSignUpButton(_ sender: UIButton) {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func tappedLoginButton(_ sender: UIButton) {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
