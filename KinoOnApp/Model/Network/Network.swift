import Foundation
import UIKit

class NetworkError: Error {
    private var msg: String

    init(msg: String) {
        self.msg = msg
    }

    func error() -> String {
        return self.msg
    }
}

class Network {
    private final let host: String = "http://64.225.100.179:8080"

    func doGet(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError(msg: "Empty response")))
                return
            }

            completion(.success(data))
        }.resume()
    }

    func doPost(url: String, body: String,
                completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(host)/\(url)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: String.Encoding.utf8)

        if let token = UserDatabase().getCSRF() {
            request.setValue(token, forHTTPHeaderField: "X-CSRF-TOKEN")
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError(msg: "Empty response")))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
//                print("headers: \(httpResponse.allHeaderFields)")

                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }

                guard let token = httpResponse.allHeaderFields["Set-Cookie"] as? String else {
                    completion(.failure(NetworkError(msg: "")))
                    return
                }

                UserDatabase().saveCSRF(token: token)
            }
            if data.isEmpty {
                //decoder
            }

            completion(.success(data))
        }.resume()
    }

    func doPut(url: String, body: String,
               completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(host)/\(url)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = body.data(using: String.Encoding.utf8)
        request.httpShouldHandleCookies = true
        guard let token = UserDatabase().getCSRF() else {
            return
        }

        request.setValue(token, forHTTPHeaderField: "X-CSRF-TOKEN")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError(msg: "Empty response")))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                let json = String(data: data, encoding: String.Encoding.utf8)
                print("respBody: \(json)")

                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }
            }
            if data.isEmpty {
                // decoder
            }

            completion(.success(data))
        }.resume()
    }

    func doDelete(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(host)/\(url)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError(msg: "Empty response")))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")

                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }
            }

            completion(.success(data))
        }.resume()
    }

    func doPostMedia(url: String, image: UIImage, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(host)/\(url)") else {
            return
        }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"

        guard let token = UserDatabase().getCSRF() else {
            return
        }
        request.setValue(token, forHTTPHeaderField: "X-CSRF-TOKEN")

        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let retreivedImage: UIImage? = image

        let imageData = retreivedImage!.jpegData(compressionQuality: 1)
        if imageData == nil {
            print("UIImageJPEGRepresentation return nil")
            return
        }

        let body = NSMutableData()
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Disposition: form-data; name=\"file\"; filename=\"testing.jpg\"\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(imageData!)
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        request.httpBody = body as Data

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError(msg: "Empty response")))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")

                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }
            }

            completion(.success(data))
        }.resume()
    }
}
