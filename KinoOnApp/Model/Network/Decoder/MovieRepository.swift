import Foundation

class MovieCollectionRepository {
    private let network = Network()
    
    func getHomePageCollection(
        completion: @escaping (Result<[MovieCollection], Error>) -> Void) {
        
        network.doGet(url: "index") {(result) in
            switch result {
            case .success(let data):
                do {
                    let collection = try self.decodeMovieCollection(data: data)
                    completion(.success(collection))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decodeMovieCollection(data: Data) throws -> [MovieCollection] {
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(ResponseBody<[MovieCollectionJson]>.self, from: data)
        var result: [MovieCollection] = []
        
        for collection in responseBody.body {
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
        
        return result
    }
}
