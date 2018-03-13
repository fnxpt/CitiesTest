import XCTest
import CoreLocation
@testable import Cities

class ListPresenterTests: XCTestCase {
    
    let cities: [City] = [
        City(identifier: 2, name: "Albuquerque", country: "US", coordinate: CLLocationCoordinate2D()),
        City(identifier: 1, name: "Alabama", country: "US", coordinate: CLLocationCoordinate2D()),
        City(identifier: 5, name: "Sidney", country: "AU", coordinate: CLLocationCoordinate2D()),
        City(identifier: 3, name: "Anaheim", country: "US", coordinate: CLLocationCoordinate2D()),
        City(identifier: 4, name: "Arizona", country: "US", coordinate: CLLocationCoordinate2D())
    ]
    var presenter: ListPresenter!
    
    override func setUp() {
        super.setUp()
        
        presenter = ListPresenter(items: cities)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUnfilteredList() {
        
        let expectation = self.expectation(description: "Wait for load completion")
        
        presenter.load(text: nil) { [unowned self] error in
            
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(self.presenter.items.count, 2, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfGroups(), 2, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.title(for: 0), "A", "The section header should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 0), 4, "The number of items should be the same")
            XCTAssertEqual(self.presenter.title(for: 1), "S", "The section header should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 1), 1, "The number of items should be the same")
            
            let city0 = self.presenter.item(at: IndexPath(item: 0, section: 0))
            let city1 = self.presenter.item(at: IndexPath(item: 1, section: 0))
            let city2 = self.presenter.item(at: IndexPath(item: 2, section: 0))
            let city3 = self.presenter.item(at: IndexPath(item: 3, section: 0))
            let city4 = self.presenter.item(at: IndexPath(item: 0, section: 1))
            
            XCTAssertNotNil(city0, "City shouldn't be nil")
            XCTAssertEqual(city0!, self.cities[1], "The city should be equal")
            XCTAssertNotNil(city1, "City shouldn't be nil")
            XCTAssertEqual(city1!, self.cities[0], "The city should be equal")
            XCTAssertNotNil(city2, "City shouldn't be nil")
            XCTAssertEqual(city2!, self.cities[3], "The city should be equal")
            XCTAssertNotNil(city3, "City shouldn't be nil")
            XCTAssertEqual(city3!, self.cities[4], "The city should be equal")
            XCTAssertNotNil(city4, "City shouldn't be nil")
            XCTAssertEqual(city4!, self.cities[2], "The city should be equal")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testFilterWithAPrefix() {
//        If the given prefix is 'A', all cities but Sydney should appear.
//        Contrariwise, if the given prefix is “s”, the only result should be “Sydney, AU”.
        
        let expectation = self.expectation(description: "Wait for load completion")
        
        presenter.load(text: "A") { [unowned self] error in
            
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(self.presenter.items.count, 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfGroups(), 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.title(for: 0), "A", "The section header should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 0), 4, "The number of items should be the same")
            
            let city0 = self.presenter.item(at: IndexPath(item: 0, section: 0))
            let city1 = self.presenter.item(at: IndexPath(item: 1, section: 0))
            let city2 = self.presenter.item(at: IndexPath(item: 2, section: 0))
            let city3 = self.presenter.item(at: IndexPath(item: 3, section: 0))
            
            XCTAssertNotNil(city0, "City shouldn't be nil")
            XCTAssertEqual(city0!, self.cities[1], "The city should be equal")
            XCTAssertNotNil(city1, "City shouldn't be nil")
            XCTAssertEqual(city1!, self.cities[0], "The city should be equal")
            XCTAssertNotNil(city2, "City shouldn't be nil")
            XCTAssertEqual(city2!, self.cities[3], "The city should be equal")
            XCTAssertNotNil(city3, "City shouldn't be nil")
            XCTAssertEqual(city3!, self.cities[4], "The city should be equal")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testFilterWithAlPrefix() {
//        If the given prefix is “Al”, “Alabama, US” and “Albuquerque, US” are the only results.
        
        let expectation = self.expectation(description: "Wait for load completion")
        
        presenter.load(text: "Al") { [unowned self] error in
            
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(self.presenter.items.count, 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfGroups(), 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.title(for: 0), "A", "The section header should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 0), 2, "The number of items should be the same")
            
            let city0 = self.presenter.item(at: IndexPath(item: 0, section: 0))
            let city1 = self.presenter.item(at: IndexPath(item: 1, section: 0))
            
            XCTAssertNotNil(city0, "City shouldn't be nil")
            XCTAssertEqual(city0!, self.cities[1], "The city should be equal")
            XCTAssertNotNil(city1, "City shouldn't be nil")
            XCTAssertEqual(city1!, self.cities[0], "The city should be equal")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testFilterWithAlbPrefix() {
//    If the prefix given is “Alb” then the only result is “Albuquerque, US”
        
        let expectation = self.expectation(description: "Wait for load completion")
        
        presenter.load(text: "Alb") { [unowned self] error in
            
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(self.presenter.items.count, 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfGroups(), 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.title(for: 0), "A", "The section header should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 0), 1, "The number of items should be the same")
            
            let city0 = self.presenter.item(at: IndexPath(item: 0, section: 0))
            
            XCTAssertNotNil(city0, "City shouldn't be nil")
            XCTAssertEqual(city0!, self.cities[0], "The city should be equal")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func testFilterWithSPrefix() {
        //    If the prefix given is “S” then the only result is “Sidney, AU”
        let expectation = self.expectation(description: "Wait for load completion")
        
        presenter.load(text: "S") { [unowned self] error in
            
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(self.presenter.items.count, 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfGroups(), 1, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.title(for: 0), "S", "The section header should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 0), 1, "The number of items should be the same")
            
            let city0 = self.presenter.item(at: IndexPath(item: 0, section: 0))
            
            XCTAssertNotNil(city0, "City shouldn't be nil")
            XCTAssertEqual(city0!, self.cities[2], "The city should be equal")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
        
    }
    
    func testFilterWithFPrefix() {
        //    If the prefix given is “F” then there shouldn't be any results
        let expectation = self.expectation(description: "Wait for load completion")
        
        presenter.load(text: "F") { [unowned self] error in
            
            XCTAssertNil(error, "Error should be nil")
            XCTAssertEqual(self.presenter.items.count, 0, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfGroups(), 0, "The number of sections should be the same")
            XCTAssertEqual(self.presenter.numberOfItems(group: 0), 0, "The number of items should be the same")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
        
    }
}
