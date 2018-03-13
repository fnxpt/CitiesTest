import Foundation

class UserLoadPresenter: LoadPresenterProtocol {
    
    func load(completion: @escaping (_ result: [City]?, _ error: Error?) -> Void) {
        
        DispatchQueue(label: "background").async {
            
            let items = UserDefaults.standard.array(forKey: "cities") as? [City]
            let error = items != nil ? ServiceError.unexpected : nil
            
            DispatchQueue.main.async {
                completion(items, error)
            }
        }
    }
}
