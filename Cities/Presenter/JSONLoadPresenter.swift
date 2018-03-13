import Foundation
import UIKit

class JSONLoadPresenter: LoadPresenterProtocol {
    
    func load(completion: @escaping (_ result: [City]?, _ error: Error?) -> Void) {
        
        CitiesRequest.getCities { (response) in
            
            switch response {
            case .error(let error):
                completion(nil, error)
            case .success(let cities):
                
                let items = cities.sorted { (city1, city2) -> Bool in
                    return city1.name.lowercased() < city2.name.lowercased()
                }
                
                completion(items, nil)
            }
        }
    }
}
