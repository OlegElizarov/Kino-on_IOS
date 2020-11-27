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
        guard let request = URL(string: "\(host)/\(url)") else {
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
}
