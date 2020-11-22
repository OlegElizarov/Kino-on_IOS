import Foundation

struct MovieCard {
    let id: Int
    let name: String
    let ageLimit: Int
    let image: String
}

struct MovieCardJson: Codable {
    var id: Int
    var name: String
    var ageLimit: Int
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "russianName"
        case ageLimit
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        ageLimit = try container.decode(Int.self, forKey: .ageLimit)
        image = try container.decode(String.self, forKey: .image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(ageLimit, forKey: .ageLimit)
        try container.encode(image, forKey: .image)
    }
}
