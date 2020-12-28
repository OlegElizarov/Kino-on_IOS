import Foundation

struct ResponseBody<T: Decodable>: Decodable {
    var status: Int
    var body: T

    enum CodingKeys: String, CodingKey {
        case status
        case body
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        body = try container.decode(T.self, forKey: .body)
    }
}
