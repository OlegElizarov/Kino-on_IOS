import Foundation

struct Filters {
    var genre: [FilterItem]
    var year: [FilterItem]
    var order: [FilterItem]
}

struct FiltersJson: Codable {
    
    
    var genre: [FilterItemJson]
    var year: [FilterItemJson]
    var order: [FilterItemJson]
    
    enum CodingKeys: String, CodingKey {
        case genre
        case year
        case order
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genre = try container.decode([FilterItemJson].self, forKey: .genre)
        year = try container.decode([FilterItemJson].self, forKey: .year)
        order = try container.decode([FilterItemJson].self, forKey: .order)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(genre, forKey: .genre)
        try container.encode(year, forKey: .year)
        try container.encode(order, forKey: .order)
    }
}
