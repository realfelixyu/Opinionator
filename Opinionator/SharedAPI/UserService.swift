//
//  UserService.swift
//  Opinionator
//
//  Created by Felix Yu on 11/6/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import Firebase
import UIKit

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
}
