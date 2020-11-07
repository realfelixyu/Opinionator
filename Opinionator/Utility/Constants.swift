//
//  Constants.swift
//  Opinionator
//
//  Created by Felix Yu on 10/19/20.
//  Copyright © 2020 Felix Yu. All rights reserved.
//

import Foundation
import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWINGS = DB_REF.child("user-followings")

let REF_USER_USERNAMES = DB_REF.child("user-usernames")

let REF_QUIZ = DB_REF.child("quizzes")
