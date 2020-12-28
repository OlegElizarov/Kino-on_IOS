import UIKit

class UserDefaultsRepository {
    
    func getData(userKey: String) -> Data {
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: userKey) as? Data {
            return data
            //            let decoder = JSONDecoder()
            //            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
            //                print(loadedPerson.name)
            //            }
        }
        return Data()
    }
    
    func saveData<T: Encodable>(value: T, userKey: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: userKey)
        }
    }
    
    func removeData(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
