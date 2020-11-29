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
    
    func doPost(url: String, body: String,
                completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(host)/\(url)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: String.Encoding.utf8)
//        request.setValue("0429e8d75f4e5d399b5f1ec13dd51e4aa5eaf831a2ffc094d4bebe228484bf42; Path=/; Expires=Sat, 28 Nov 2020 03:09:48 GMT", forHTTPHeaderField: "X-CSRF-TOKEN")
//        request.setValue("session_id=a75095ab-91d6-4b77-bbee-91deeafdbc6f; Path=/; Expires=Sat, 28 Nov 2020 03:09:48 GMT; HttpOnly;", forHTTPHeaderField: "set-cookie")
//        request.setValue("true", forHTTPHeaderField: "access-control-allow-credentials")
//        request.setValue("", forHTTPHeaderField: "access-control-allow-origin")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError(msg: "Empty response")))
                return
            }
            print(response!)

            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                let json = String(data: data, encoding: String.Encoding.utf8)
                print("respBodu: \(json)")

                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }
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
            print(response!)

            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                let json = String(data: data, encoding: String.Encoding.utf8)
                print("respBodu: \(json)")

                if httpResponse.statusCode != 200 {
                    completion(.failure(NetworkError(msg: "not 200")))
                    return
                }
            }
            
            completion(.success(data))
        }.resume()
    }
}

//{"username": "Oleg1","password": "123abc"} POSTPARAMS
//<NSHTTPURLResponse: 0x60000395ca00> { URL: http://64.225.100.179:8080/login } { Status Code: 200, Headers {
//    "Access-Control-Allow-Credentials" =     (
//        true
//    );
//    "Access-Control-Allow-Origin" =     (
//        ""
//    );
//    "Content-Length" =     (
//        85
//    );
//    "Content-Type" =     (
//        "text/plain; charset=utf-8"
//    );
//    Date =     (
//        "Sat, 28 Nov 2020 10:21:05 GMT"
//    );
//    "Set-Cookie" =     (
//        "session_id=7e3d77c3-d745-4c51-a227-db654091babd; Path=/; Expires=Sat, 28 Nov 2020 20:21:05 GMT; HttpOnly",
//        "X-CSRF-TOKEN=c0390db5d2ed596c472f6417f6fde9edcaa8bea8749535b150f63f793892cc04; Path=/; Expires=Sat, 28 Nov 2020 20:21:05 GMT"
//    );
//    Vary =     (
//        Origin
//    );
//} }
//statusCode: 200
//respBodu: Optional("{\"status\":200,\"body\":{\"id\":0,\"username\":\"Oleg1\",\"password\":\"\",\"email\":\"\",\"image\":\"\"}}")
//User(id: 0, username: "Oleg1", email: "", password: "", image: "")
