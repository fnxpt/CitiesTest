import Foundation

protocol Groupable {
    
    func numberOfGroups() -> Int
    func numberOfItems(group: Int) -> Int
    func item(at position: IndexPath) -> City?
    func title(for group: Int) -> String?
    func indexes() -> [String]?
}
