import CoreLocation

protocol CityRequestProtocol {
    static func getCities(completionHandler: @escaping (Response<[City]>) -> Void)
}

class CitiesRequest: CityRequestProtocol, Requestable {
    
    static var service: String = ""
    
    static func getCities(completionHandler: @escaping (Response<[City]>) -> Void) {
        
        if let file = Bundle.main.url(forResource: "cities", withExtension: "json") {
            self.request(path: file,
                         parameters: nil,
                         completionHandler: completionHandler)
        }
    }
}
