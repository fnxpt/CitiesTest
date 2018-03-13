import Foundation
import UIKit

typealias GroupableListPresenterProtocol = ListPresenterProtocol & Groupable

protocol ListPresenterProtocol {
    
    var cellType: UITableViewCell.Type { get }
    var items: [String: [City]] { get set }
    
    func load(text: String?,
              completion: @escaping (_ error: Error?) -> Void)
}
