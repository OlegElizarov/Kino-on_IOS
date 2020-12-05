import Foundation
import UIKit

class MovieCollectionRepository {
    private let network = Network()

    func getHomePageCollection(
            completion: @escaping (Result<[MovieCollection], Error>) -> Void) {

        network.doGet(url: "http://64.225.100.179:8080/index") { (result) in
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
                downloadImage(url: movie.image, completion: { image in
                    coll.movies.append(MovieCard(
                            id: movie.id,
                            name: movie.name,
                            ageLimit: movie.ageLimit,
                            image: image))
                })
            }

            result.append(coll)
        }

        return result
    }

    private func downloadImage(url: String, completion: @escaping (UIImage) -> Void) {
        var url = url
        if !url.starts(with: "http") {
            url = "https://kino-on.ru\(url)"
        }

        network.doGet(url: url, completion: { result in
            switch result {
            case .success(let data):
                completion(UIImage(data: data) ?? UIImage())
            case .failure(let error):
                print(error)
            }
        })
    }
}
