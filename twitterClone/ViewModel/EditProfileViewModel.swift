import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var  description: String {
        switch self {
        case .username: return "Username"
        case .fullname: return "Fullname"
        case .bio: return "Bio"
        }
    }
}
