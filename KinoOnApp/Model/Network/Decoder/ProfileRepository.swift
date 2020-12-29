import Foundation
import UIKit

class ProfileRepository {
    private let network = Network()
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let postParams = "{\"username\": \"\(username)\",\"password\": \"\(password)\"}"
        
        print(postParams, "POSTPARAMS")
        network.doPost(url: "login", body: postParams) {(result) in
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
    
    func signup(username: String, email: String, password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        let postParams = "{\"username\": \"\(username)\",\"password\": \"\(password)\" ,\"email\":\"\(email)\"}"
        
        print(postParams, "POSTPARAMS")
        network.doPost(url: "signup", body: postParams) {(result) in
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
    
    func logout(
        completion: @escaping (Result<Data, Error>) -> Void) {
        network.doDelete(url: "logout") {(result) in
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
    
    func getUser(completion: @escaping (Result<User, Error>) -> Void) {
        network.doGet(url: "http://64.225.100.179:8080/user") {(result) in
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
    
    func saveSettings(username: String, email: String, password: String,
                      completion: @escaping (Result<User, Error>) -> Void) {
        let postParams = "{\"username\": \"\(username)\",\"password\": \"\(password)\",\"email\":\"\(email)\"}"
        
        print(postParams, "PUT_PARAMS")
        network.doPut(url: "user", body: postParams) {(result) in
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
    
    func saveAvatar(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        network.doPostMedia(url: "user/image", image: image) {(result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let responseBody = try decoder.decode(ResponseBody<String>.self, from: data)
                    let result: String = responseBody.body
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func decodeUser(data: Data) throws -> User {
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(ResponseBody<User>.self, from: data)
        let result: User = responseBody.body        
        return result
    }
}
