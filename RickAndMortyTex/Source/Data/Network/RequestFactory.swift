final class RequestFactory {
    
    func create(path: String, parameters: [String : String]? = nil) -> HttpRequest {
        HttpRequest("\(APIConstants.baseURL)\(path)", parameters: parameters)
    }
    
}
