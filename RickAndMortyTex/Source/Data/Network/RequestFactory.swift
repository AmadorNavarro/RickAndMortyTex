final class RequestFactory: IRequestFactory {
    
    func create(path: String, parameters: [String : String]? = nil) -> IHttpRequest {
        HttpRequest("\(APIConstants.baseURL)\(path)", parameters: parameters)
    }
    
}
