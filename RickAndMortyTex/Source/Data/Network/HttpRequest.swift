import Foundation
import Network

final class HttpRequest: IHttpRequest {
    
    enum Method : String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private let url: String
    private var method: Method = .get
    private var headers: [String : String] = [:]
    private var body: Data?
    private let monitor = NWPathMonitor()
    private var printCurl = UserDefaults.standard.bool(forKey: "printCurl")
    private var printResponse = UserDefaults.standard.bool(forKey: "printLog")
    var urlSession: IURLSession = URLSession.shared
    var networkConexion = true
    
    // MARK: - Initializers
    init(_ path: String) {
        self.url = path
        configureNetworkMonitor()
    }
    
    convenience init(_ path: String, parameters: [String : String]?) {
        self.init("\(path)\(HttpRequest.getQuery(parameters))")
    }
    
    deinit {
        monitor.cancel()
    }
    
    // MARK: - Public methods
    
    // Adds or updates a header of the request
    func header(_ name: String, _ value: String) -> Self {
        headers[name] = value
        return self
    }
    
    // Sets the method of the request
    func method(_ method: Method) -> Self {
        self.method = method
        return self
    }
    
    // Sets the request body
    func body(data: Data?) -> Self {
        body = data
        return self
    }
    
    func connect() async throws -> HttpResponse {
        
        // Bail out at the beginning if the url is not valid
        guard let url = URL(string: url) else {
            throw HttpError.invalidUrl
        }
        
        // 
        guard networkConexion else {
            throw HttpError.noNetworkError
        }

        // Return the prepared request
        return try await prepareRequest(url)
        
    }
    
    // MARK: - Private methods
    private func configureNetworkMonitor() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.networkConexion = path.status == .satisfied
        }
        
        monitor.start(queue: DispatchQueue.main)
        
    }
    
    private class func getQuery(_ parameters: [String : String]?) -> String {
        
        guard let parameters = parameters, !parameters.isEmpty else { return "" }
        var queryParameters: [String] = []
        
        for (key, value) in parameters {
            guard let encoded = value.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { continue }
            queryParameters.append("\(key)=\(encoded)")
        }
        
        return "?" + queryParameters.joined(separator: "&")
        
    }
    
    private func prepareRequest(_ url: URL) async throws -> HttpResponse {
        
        // Create the request with its URL and method
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Add the request body
        request.httpBody = body
        
        // Add the headers
        for (name, value) in headers {
            request.setValue(value, forHTTPHeaderField: name)
        }
        
        #if DEBUG
        // Log the curl equivalent command if requested
        if printCurl {
            logCurl()
        }
        
        #endif
        return try await sendRequest(request)
        
    }
    
    private func sendRequest(_ request: URLRequest) async throws -> HttpResponse {
        
        try await withCheckedThrowingContinuation { continuation in

            urlSession.dataTask(with: request) { [weak self] (data, response, error) in
                
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: error ?? HttpError.unknownNetworkError)
                    return
                }
                
                #if DEBUG
                if let self = self, self.printResponse {
                    self.logResponse(data: data, response: response)
                }
                #endif
                
                continuation.resume(returning: HttpResponse(response.statusCode, data))

            }.resume()

        }

    }
    
    #if DEBUG
    private func logCurl() {
        
        var components = [ "curl", "'\(url)'", "-X", method.rawValue ]
        
        for (name, value) in headers {
            components.append("-H")
            components.append("'\(name): \(value)'")
        }
        
        if let body = body, let bodyString = String(data: body, encoding: .utf8) {
            components.append("--data")
            components.append("'\(bodyString)'")
        }
        
        let curl = components.joined(separator: " ")
        
        print(curl)
        
    }
    
    private func logResponse(data: Data?, response: HTTPURLResponse) {
        
        var response = "HEADERS: \(response.allHeaderFields)\n\n"
        
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
            response += "RESPONSE: \(json)\n"
        }
        
        print(response)
        
    }
    #endif
    
}
