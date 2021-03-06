import Foundation
import UIKit

class FilmRepository {
    private let network = Network()
    private let group = DispatchGroup()

    func getFilm(id: Int, completion: @escaping (Result<Film, Error>) -> Void) {
        network.doGet(url: "http://64.225.100.179:8080/films/\(id)") { result in
            switch result {
            case .success(let data):
                do {
                    let film = try self.decodeFilmInfo(data: data)
                    completion(.success(film))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func decodeFilmInfo(data: Data) throws -> Film {
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(ResponseBody<FilmFullInfo>.self, from: data)

        let film = Film()
        film.id = responseBody.body.film.id
        film.title = responseBody.body.film.title
        film.description = responseBody.body.film.description
        film.trailerUrl = responseBody.body.film.trailerUrl
        film.imgUrl = responseBody.body.film.imgUrl

        return film
    }

    func downloadImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        var url = url
        if !url.starts(with: "http") {
            url = "https://kino-on.ru\(url)"
        }

        self.network.doGet(url: url, completion: { result in
            switch result {
            case .success(let data):
                completion(.success(UIImage(data: data) ?? UIImage()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
