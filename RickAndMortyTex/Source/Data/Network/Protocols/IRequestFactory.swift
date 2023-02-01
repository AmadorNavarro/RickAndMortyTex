protocol IRequestFactory {
    
    func create(path: String, parameters: [String : String]?) -> IHttpRequest
    
}

extension IRequestFactory {
    
    func create(path: String, parameters: [String : String]? = nil) -> IHttpRequest {
        create(path: path, parameters: parameters)
    }
    
}
