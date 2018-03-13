protocol LoadPresenterProtocol {
    
    func load(completion: @escaping (_ result: [City]?, _ error: Error?) -> Void)
}
