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
    
    var usernameFormated: String {
        return "@\(user.username)"
    }
    
    var followerString: NSAttributedString? {
        return attributedText(withValue: user.stats?.followers ?? 0, text: " Followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: " Following")
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return "Loading"
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
