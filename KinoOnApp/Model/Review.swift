import Foundation

class UserInfo {
    var username: String = ""
    var image: String = ""
}

class Review {
    var id: Int = 0
    var rating: Float = 0
    var body: String = ""
    var userId: Int = 0
    var productId: Int = 0
    var user: UserInfo = UserInfo()
}

class UserInfoJson: Codable {
    var username: String
    var image: String
}

class ReviewJson: Codable {
    var id: Int
    var rating: Float
    var body: String
    var userId: Int
    var productId: Int
    var user: UserInfoJson
}
