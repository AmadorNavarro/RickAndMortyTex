@testable import RickAndMortyTex
import Foundation

final class MockRequestFactory: IRequestFactory {
    
    var throwError: HttpError?
    var data: Data = Data()
    
    func create(path: String, parameters: [String : String]? = nil) -> IHttpRequest {
        MockHttpRequest(data, throwError)
    }
    
}

final class MockHttpRequest: IHttpRequest {
    
    var throwError: HttpError?
    var data: Data
    
    init(_ data: Data, _ error: HttpError?) {
        self.data = data
        self.throwError = error
    }
    
    func connect() async throws -> HttpResponse {
        
        if let error = throwError {
            throw error
        }
        
        return HttpResponse(200, data)
        
    }
    
}
