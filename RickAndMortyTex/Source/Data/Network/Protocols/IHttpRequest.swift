protocol IHttpRequest {
    
    func connect() async throws -> HttpResponse
    
}
