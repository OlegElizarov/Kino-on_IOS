import Foundation

struct MovieCollection {
    let name: String
    var movies: [MovieCard]
}

struct MovieCollectionJson: Codable {
    var id: Int
    var name: String
    var movies: [MovieCardJson]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case movies = "films"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        movies = try container.decode([MovieCardJson].self, forKey: .movies)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(movies, forKey: .movies)
    }
}
