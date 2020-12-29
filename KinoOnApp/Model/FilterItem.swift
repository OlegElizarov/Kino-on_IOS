import Foundation

struct FilterItem {
    let name: String
    let reference: String
}

struct FilterItemJson: Codable {
    var name: String
    var reference: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case reference
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        reference = try container.decode(String.self, forKey: .reference)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(reference, forKey: .reference)
    }
}
