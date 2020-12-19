import Foundation
import UIKit

struct FilmBannerInfo {
    var title: String
    var description: String
    var img: String
}

class Film {
    var id: Int
    var title: String
    var description: String
    var imgUrl: String
    var trailerUrl: String

    init() {
        id = 0
        title = ""
        description = ""
        imgUrl = ""
        trailerUrl = ""
    }
}

struct FilmFullInfo: Codable {
    var film: FilmJson

    enum CodingKeys: String, CodingKey {
        case film = "object"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        film = try container.decode(FilmJson.self, forKey: .film)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(film, forKey: .film)
    }
}

struct FilmJson: Codable {
    var id: Int
    var title: String
    var description: String
    var imgUrl: String
    var trailerUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case title = "russianName"
        case description
        case img = "backgroundImage"
        case trailer = "trailerLink"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        imgUrl = try container.decode(String.self, forKey: .img)
        trailerUrl = try container.decode(String.self, forKey: .trailer)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(imgUrl, forKey: .img)
        try container.encode(trailerUrl, forKey: .trailer)
    }
}