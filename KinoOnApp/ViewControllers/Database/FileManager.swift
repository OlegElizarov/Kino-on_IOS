import UIKit

class FileManagerRepository {
    
    let filename = "user.txt"
    let fileEncoding: String.Encoding = .utf8
    let fileManager = FileManager.default
    
    func getData() -> Data {
        guard let url = documentsDirUrl() else {
            print("can't get dir url")
            return Data()
        }
        
        let fileUrl = url.appendingPathComponent(self.filename)
        
        var contents: String = ""
        
        if self.fileManager.fileExists(atPath: fileUrl.path) {
            contents = (try? String(contentsOf: fileUrl, encoding: self.fileEncoding)) ?? ""
        } else {
            print("not exists")
            return Data()
        }
        
        let data = contents.data(using: fileEncoding)!
        return data
        
    }
    
    func saveData<T: Encodable>(value: T) {
        let encoder: JSONEncoder = .init()
        let data: Data
        
        do {
            try data = encoder.encode(value)
        } catch {
            print("can't convert value to Data")
            return
        }
        
        guard let url = documentsDirUrl() else {
            debugPrint("failed to get documents dir url")
            return
        }
        
        let fileUrl = url.appendingPathComponent(self.filename)
        
        do {
            try data.write(to: fileUrl, options: .atomic)
        } catch {
            print("can't save Data")
            return
        }
        print("saved to \(fileUrl)")
    }
}

func documentsDirUrl() -> URL? {
    try? FileManager.default.url(for: .documentDirectory,
                                 in: .userDomainMask,
                                 appropriateFor: nil,
                                 create: false)
}
