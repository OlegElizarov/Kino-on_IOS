import UIKit

class UserDatabase {
    private let userKey: String = "kino-on-user"
    private let XCSRF: String = "X-CSRF-TOKEN"
    private let regXCSRF: String = "X-CSRF-TOKEN=[0-9a-z]+"
    
    func saveUserData(user: User) {
        UserDefaultsRepository().saveData(value: user, userKey: self.userKey)
    }
    
    func getUserData() -> User? {
        let data = UserDefaultsRepository().getData(userKey: self.userKey)
        let decoder: JSONDecoder = .init()
        guard let user = try? decoder.decode(User.self, from: data) else {
            print("bad user data")
            return nil
        }
        return user
    }
    
    func removeUser() {
        UserDefaultsRepository().removeData(key: self.userKey)
    }
    
    func saveCSRF(token: String) {
        let res = matches(for: self.regXCSRF, in: token)[0]
        let index = token.index(token.startIndex, offsetBy: 13)
        let CSRF = res[index...]
        UserDefaultsRepository().saveData(value: String(CSRF), userKey: self.XCSRF)
        print("CSRF : \(CSRF) saved")
    }
    
    func getCSRF() -> String? {
        let data = UserDefaultsRepository().getData(userKey: self.XCSRF)
        let decoder: JSONDecoder = .init()
        guard let token = try? decoder.decode(String.self, from: data) else {
            print("bad token data")
            return nil
        }
        return token
    }
    
    private func matches(for regex: String, in text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}
