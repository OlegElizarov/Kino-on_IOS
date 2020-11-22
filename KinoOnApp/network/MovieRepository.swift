import Foundation

struct ResponseBody: Decodable {
    var status: Int
    var collections: [MovieCollectionJson]
    
    enum CodingKeys: String, CodingKey {
        case status
        case collections = "body"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Int.self, forKey: .status)
        collections = try container.decode([MovieCollectionJson].self, forKey: .collections)
    }
}

class MovieCollectionRepository {
    func getHomePageCollection(
        completion: @escaping (Result<[MovieCollection], Error>) -> Void) {
        
        guard let homePageCollectionUrl = URL(string: "http://64.225.100.179:8080/index") else {
            return
        }
        
        URLSession.shared.dataTask(with: homePageCollectionUrl) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.success([]))
                return
            }

            let decoder = JSONDecoder()
            
            do {
                let responseBody = try decoder.decode(ResponseBody.self, from: data)
                var result: [MovieCollection] = []
                
                for collection in responseBody.collections {
                    var coll = MovieCollection(name: collection.name, movies: [])
                    
                    for movie in collection.movies {
                        coll.movies.append(MovieCard(
                                            id: movie.id,
                                            name: movie.name,
                                            ageLimit: movie.ageLimit,
                                            image: movie.image))
                    }
                    
                    result.append(coll)
                }
                
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
                return
            }
        }.resume()
    }
}
