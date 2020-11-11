//
//  AuthService.swift
//  Opinionator
//
//  Created by Felix Yu on 10/19/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials{
    let email: String
    let password: String
    let username: String
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let username = credentials.username

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error is \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else {return}
            
            let values = ["email": email, "username": username]
            REF_USERS.child(uid).updateChildValues(values) { (err, ref) in
                if err == nil {
                    REF_USERNAMES.updateChildValues([username: uid], withCompletionBlock: completion)
                }
            }
        }
    }
}
