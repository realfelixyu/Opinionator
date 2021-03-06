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
let STORAGE_QUIZ_IMAGES = STORAGE_REF.child("quiz-bucket-images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWINGS = DB_REF.child("user-followings")

let REF_USER_USERNAMES = DB_REF.child("user-usernames")

let REF_QUIZ = DB_REF.child("quizzes")
//maps quiz title to their hash value
let REF_QUIZTITLES = DB_REF.child("quiztitle-quizid")
//maps usernames to userid
let REF_USERNAMES = DB_REF.child("usernames-userid")

func getTopSafeAreaHeight() -> CGFloat {
    let window = UIApplication.shared.windows[0]
    let safeFrame = window.safeAreaLayoutGuide.layoutFrame
    var topSafeAreaHeight = safeFrame.minY
    return topSafeAreaHeight
}
