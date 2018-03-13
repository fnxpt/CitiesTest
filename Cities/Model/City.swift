import CoreLocation

class City: Decodable {
    
    var identifier: Int
    var name: String
    var country: String
    var coordinate: CLLocationCoordinate2D
    
    private enum JSONKeys: String, CodingKey {
        case identifier = "_id"
        case name
        case country
        case coordinates = "coord"
        
        //swiftlint:disable:next nesting
        enum Coordinates: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }
    
    init(identifier: Int, name: String, country: String, coordinate: CLLocationCoordinate2D) {
        
        self.identifier = identifier
        self.name = name
        self.country = country
        self.coordinate = coordinate
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: JSONKeys.self)
        
        identifier = try container.decode(Int.self, forKey: .identifier)
        name = try container.decode(String.self, forKey: .name)
        country = try container.decode(String.self, forKey: .country)
        
        let coordinateContainer = try container.nestedContainer(keyedBy: JSONKeys.Coordinates.self,
                                                                forKey: .coordinates)
        
        let latitude = try coordinateContainer.decode(Double.self, forKey: .latitude)
        let longitude = try coordinateContainer.decode(Double.self, forKey: .longitude)
        
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension City: Equatable {
    
    static func == (lhs: City, rhs: City) -> Bool {
        
        return lhs.identifier == rhs.identifier &&
            lhs.name == rhs.name &&
            lhs.country == rhs.country &&
            lhs.coordinate.latitude == rhs.coordinate.latitude &&
            lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}
