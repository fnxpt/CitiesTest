import Foundation
import UIKit

class ListPresenter: ListPresenterProtocol {
    
    var cellType: UITableViewCell.Type = CityCell.self
    var cached: [City]
    var items: [String: [City]] = [:]
    let queue = OperationQueue()
    
    init(items: [City]) {
        
        cached = items.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.name < rhs.name
        })
    }
    
    func load(text: String?,
              completion: @escaping (_ error: Error?) -> Void) {
        
        queue.cancelAllOperations()
        queue.addOperation {
            
            let collation = UILocalizedIndexedCollation.current()
            var items: [City] = self.cached
            
            if let text = text {
                items = items.filter { $0.name.hasPrefix(text) }
            }
            
            self.items = Dictionary(grouping: items) {
                let index = collation.section(for: $0.name,
                                              collationStringSelector: #selector(getter: NSString.uppercased))
                return collation.sectionIndexTitles[index]
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}

extension ListPresenter: Groupable {
    
    func numberOfGroups() -> Int {
        
        return items.keys.count
    }
    
    func numberOfItems(group: Int) -> Int {
        guard let indexes = indexes(),
            indexes.count > group else { return 0 }
        
        let letter = indexes[group]
        
        guard let section = items[letter] else {
            
            return 0
        }
        
        return section.count
    }
    
    func item(at position: IndexPath) -> City? {
        guard let indexes = indexes(),
            indexes.count > position.section else { return nil }
        
        let letter = indexes[position.section]
        
        guard let section = items[letter] else {
            
            return nil
        }
        
        return section[position.item]
    }
    
    func title(for group: Int) -> String? {
        guard let indexes = indexes(),
            indexes.count > group else { return nil }
        
        let letter = indexes[group]
        
        return letter
    }
    
    func indexes() -> [String]? {
        
        return Array(items.keys).sorted()
    }
}
