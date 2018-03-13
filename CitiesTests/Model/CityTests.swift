import XCTest
import CoreLocation
@testable import Cities

class CityTests: XCTestCase {
    
    func testCityInitializer() {
        
        let item = City(identifier: 1,
                        name: "Lisbon",
                        country: "Portugal",
                        coordinate: CLLocationCoordinate2D(latitude: 38.736946, longitude: -9.142685))
        
        XCTAssertNotNil(item, "Item shouldn't be nil")
        XCTAssertEqual(item.identifier, 1, "Identifier should be equal")
        XCTAssertEqual(item.name, "Lisbon", "Name should be equal")
        XCTAssertEqual(item.country, "Portugal", "Country should be equal")
        XCTAssertEqual(item.coordinate.latitude, 38.736946, "Latitude should be equal")
        XCTAssertEqual(item.coordinate.longitude, -9.142685, "Longitude should be equal")
    }
    
    func testCityInitializerWithInvalidCoordinates() {
        
        let item = City(identifier: -1,
                        name: "London",
                        country: "UK",
                        coordinate: CLLocationCoordinate2D())
        
        XCTAssertNotNil(item, "Item shouldn't be nil")
        XCTAssertEqual(item.identifier, -1, "Identifier should be equal")
        XCTAssertEqual(item.name, "London", "Name should be equal")
        XCTAssertEqual(item.country, "UK", "Country should be equal")
        XCTAssertEqual(item.coordinate.latitude, 0, "Latitude should be equal")
        XCTAssertEqual(item.coordinate.longitude, 0, "Longitude should be equal")
    }
}
