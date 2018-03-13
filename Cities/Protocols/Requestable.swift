import Foundation

protocol Requestable {
    
    static var service: String { get }
    
    static func request<T: Decodable>(path: URL,
                                      parameters: [String: String]?,
                                      completionHandler: @escaping (Response<T>) -> Void)
}

extension Requestable {
    
    internal static func request<T>(path: URL,
                                    parameters: [String : String]?,
                                    completionHandler: @escaping (Response<T>) -> Void) where T: Decodable {
        
        let session = URLSession.shared
        let task = session.dataTask(with: path) { (data, _, error) in
            
            if let error = error {
                
                completionHandler(.error(error: error))
            } else if let data = data {
                
                do {
                    let object = try T.decode(data: data)
                    completionHandler(.success(object: object))
                } catch {
                    
                    completionHandler(.error(error: error))
                }
            } else {
                
                completionHandler(.error(error: ServiceError.unexpected))
            }
        }
        
        task.resume()
    }
}
