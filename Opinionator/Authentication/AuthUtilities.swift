//
//  AuthUtilities.swift
//  Opinionator
//
//  Created by Felix Yu on 9/17/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation

class AuthUtilities {
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
