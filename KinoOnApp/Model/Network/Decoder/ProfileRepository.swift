import Foundation

class ProfileRepository {
    private let network = Network()
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let postParams = "{\"username\": \"\(username)\",\"password\": \"\(password)\"}"
        
        print(postParams, "POSTPARAMS")
        network.doPost(url: "login", body: postParams) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let user = try self.decodeUser(data: data)
                        completion(.success(user))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signup(username: String, email: String, password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        let postParams = "{\"username\": \"\(username)\",\"password\": \"\(password)\" ,\"email\":\"\(email)\"}"
                
        print(postParams, "POSTPARAMS")
        network.doPost(url: "signup", body: postParams) {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let user = try self.decodeUser(data: data)
                        completion(.success(user))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func logout(
        completion: @escaping (Result<Data, Error>) -> Void) {
        network.doDelete(url: "logout") {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        completion(.success(data))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        network.doGet(url: "user") {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    do {
                        let user = try self.decodeUser(data: data)
                        completion(.success(user))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func decodeUser(data: Data) throws -> User {
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(ResponseBody<User>.self, from: data)
        let result: User = responseBody.body        
        return result
    }
}
