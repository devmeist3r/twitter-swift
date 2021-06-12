//
//  Constants.swift
//  twitterClone
//
//  Created by Lucas Inocencio on 28/08/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import Firebase


let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")
let REF_TWEETS = DB_REF.child("tweets")
let REF_USER_TWEETS = DB_REF.child("user-tweets")
