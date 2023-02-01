protocol IRequestFactory {
    
    func create(path: String, parameters: [String : String]?) -> HttpRequest
    
}

extension IRequestFactory {
    
    func create(path: String, parameters: [String : String]? = nil) -> HttpRequest {
        create(path: path, parameters: parameters)
    }
    
}
