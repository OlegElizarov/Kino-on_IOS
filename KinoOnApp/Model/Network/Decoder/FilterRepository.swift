import Foundation

class FilterRepository {
    private let network = Network()
    
    func getFilters(type: ContentType ,completion: @escaping (Result<Filters, Error>) -> Void) {
        var urlPrefix = "series"
        if (type == ContentType.Movies) {
            urlPrefix = "films"
        }
        
        network.doGet(url: "\(urlPrefix)/filter") {(result) in
            switch result {
            case .success(let data):
                do {
                    let filters = try self.decodeFilters(data: data)
                    completion(.success(filters))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func decodeFilters(data: Data) throws -> Filters {
        let decoder = JSONDecoder()
        let responseBody = try decoder.decode(ResponseBody<FiltersJson>.self, from: data)
        var result = Filters(genre: [], year: [], order: [])
        
        for genre in responseBody.body.genre {
            result.genre.append(FilterItem(name: genre.name, reference: genre.reference))
        }
        
        let allYearsItem = responseBody.body.year[0]
        result.year.append(FilterItem(name: allYearsItem.name, reference: allYearsItem.reference))
        
        let yearFrom = Int(responseBody.body.year[2].reference)
        let yearTo = Int(responseBody.body.year[1].reference)
        for year in yearFrom!...yearTo! {
            result.year.append(FilterItem(name: String(year), reference: String(year)))
        }
        
        for order in responseBody.body.order {
            result.order.append(FilterItem(name: order.name, reference: order.reference))
        }
        
        return result
    }
}
