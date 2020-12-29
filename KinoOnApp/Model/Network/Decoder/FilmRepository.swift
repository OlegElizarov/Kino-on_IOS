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

    func getReviews(filmId: Int, completion: @escaping (Result<[Review], Error>) -> Void) {
        network.doGet(url: "http://64.225.100.179:8080/films/\(filmId)/reviews") { result in
            switch result {
            case .success(let data):
                do {
                    let reviews = try self.decodeReviews(data: data)
                    completion(.success(reviews))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func postReview(rev: Review) {
        let url = "films/\(rev.productId)/reviews"
        let body = "{\"rating\": \(rev.rating),\"body\": \"\(rev.body)\"}"

        network.doPost(url: url, body: body) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(_):
                print("ok")
            }
        }
    }

    private func decodeReviews(data: Data) throws -> [Review] {
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(ResponseBody<[ReviewJson]>.self, from: data)
        var result: [Review] = []

        for item in responseBody.body {
            let rev = Review()

            rev.id = item.id
            rev.body = item.body
            rev.rating = item.rating
            rev.productId = item.productId
            rev.userId = item.userId
            rev.user.username = item.user.username

            result.append(rev)
        }

        return result
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
