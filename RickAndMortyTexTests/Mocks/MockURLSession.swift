import Foundation
@testable import RickAndMortyTex

final class MockURLSession: IURLSession {
    
    var error: HttpError?
    var data: Data?
    var statusCode = 500
    
    init(_ error: HttpError?) {
        self.error = error
    }
    
    init(_ data: Data?, statusCode: Int) {
        self.data = data
        self.statusCode = statusCode
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        if let error = error {
            completionHandler(nil, nil, error)
        }
        
        if let data = data {
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            completionHandler(data, response, nil)
        } else {
            completionHandler(nil, nil, nil)
        }
        
        return URLSession.shared.dataTask(with: request)
        
    }
    
}
