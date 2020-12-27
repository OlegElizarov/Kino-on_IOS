import Foundation

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let password: String
    var image: String
}
