//
//  ProfileHeaderViewModel.swift
//  twitterClone
//
//  Created by Lucas Inocencio on 05/11/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import UIKit
import Firebase

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
//    case media
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
//        case .media: return "Media"
        }
    }
}


struct ProfileHeaderViewModel {
    
    private let user: User
    
    var followerString: NSAttributedString? {
        return attributedText(withValue: 0, text: " Followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: 10, text: " Following")
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return "Follow"
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    fileprivate func attributedText(withValue value: Int, text: String?) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font: UIFont(name: "Roboto-Bold", size: 14) ?? "0"])
        
        attributedTitle.append(NSAttributedString(string: "\(text ?? "0")", attributes: [.font: UIFont(name: "Roboto-Regular", size: 14) ?? "", NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
}
