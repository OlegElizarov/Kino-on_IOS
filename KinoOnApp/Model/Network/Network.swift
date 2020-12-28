import Foundation

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
                print("headers: \(httpResponse.allHeaderFields)")

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
        print(request.allHTTPHeaderFields!)
        
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
                //decoder
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
            //            print(response!)
            
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                //                let json = String(data: data, encoding: String.Encoding.utf8)
                //                print("respBodu: \(json)")
                
                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }
            }
            
            completion(.success(data))
        }.resume()
    }
}
