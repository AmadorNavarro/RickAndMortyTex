import XCTest
@testable import RickAndMortyTex

final class HttpRequestTests: XCTestCase {
    
    private let urlTest = "https://www.test.com"

    func test_initRequest_withAStringPath_shouldSetThisPathAsUrl() throws {
        
        let sut = HttpRequest(urlTest)
        let mirror = Mirror(reflecting: sut)
        let url = try XCTUnwrap(mirror.descendant("url") as? String)
        
        XCTAssertEqual(url, "https://www.test.com")
        
    }

    func test_initRequest_withPathAndParametes_shouldConfigurateUrlCorrectly() throws {
        
        let sut = HttpRequest(urlTest, parameters: ["page" : "1"])
        let mirror = Mirror(reflecting: sut)
        let url = try XCTUnwrap(mirror.descendant("url") as? String)
        
        XCTAssertEqual(url, "https://www.test.com?page=1")
        
    }
    
    func test_initRequest_shouldSetMethodToGET() throws {
        
        let sut = HttpRequest(urlTest)
        
        let mirror = Mirror(reflecting: sut)
        let method = try XCTUnwrap(mirror.descendant("method") as? HttpRequest.Method)
        
        XCTAssertEqual(method, .get)
        
    }
    
    func test_header_withNewNameAndValue_shouldBeAdded() throws {
        
        let sut = HttpRequest(urlTest)
            .header("newHeader", "test")
        
        let mirror = Mirror(reflecting: sut)
        let headers = try XCTUnwrap(mirror.descendant("headers") as? [String : String])
        let headerValue = try XCTUnwrap(headers["newHeader"])
        
        XCTAssertEqual(headerValue, "test")
        
    }
    
    func test_header_withExistingName_shouldReplaceValue() throws {
        
        // Preconditions
        var sut = HttpRequest(urlTest)
            .header("aHeader", "newValue")
        
        // replace value
        sut = sut.header("aHeader", "otherValue")
        
        let mirror = Mirror(reflecting: sut)
        let headers = try XCTUnwrap(mirror.descendant("headers") as? [String : String])
        let headerValue = try XCTUnwrap(headers["aHeader"])
        
        XCTAssertEqual(headerValue, "otherValue")
        
    }
    
    func test_method_withPUT_shouldChangeMethodToPUT() throws {
        
        let sut = HttpRequest(urlTest)
            .method(.put)
        
        let mirror = Mirror(reflecting: sut)
        let method = try XCTUnwrap(mirror.descendant("method") as? HttpRequest.Method)
        
        XCTAssertEqual(method, .put)
        
    }
    
    func test_method_withPOST_shouldChangeMethodToPOST() throws {
        
        let sut = HttpRequest(urlTest)
            .method(.post)
        
        let mirror = Mirror(reflecting: sut)
        let method = try XCTUnwrap(mirror.descendant("method") as? HttpRequest.Method)
        
        XCTAssertEqual(method, .post)
        
    }
    
    func test_method_withDELETE_shouldChangeMethodToDELETE() throws {
        
        let sut = HttpRequest(urlTest)
            .method(.delete)
        
        let mirror = Mirror(reflecting: sut)
        let method = try XCTUnwrap(mirror.descendant("method") as? HttpRequest.Method)
        
        XCTAssertEqual(method, .delete)
        
    }
    
    func test_method_withGET_shouldChangeMethodToGET() throws {
        
        var sut = HttpRequest(urlTest)
            .method(.put)
        
        let mirror = Mirror(reflecting: sut)
        var method = try XCTUnwrap(mirror.descendant("method") as? HttpRequest.Method)
        
        XCTAssertEqual(method, .put)
        
        sut = sut.method(.get)
        method = try XCTUnwrap(mirror.descendant("method") as? HttpRequest.Method)
        
        XCTAssertEqual(method, .get)
        
    }
    
    func test_body_withData_shouldAddToBodyRequest() throws {
        
        let data = json.data(using: .utf8)
        let sut = HttpRequest(urlTest)
            .body(data: data)
        
        let mirror = Mirror(reflecting: sut)
        let body = try XCTUnwrap(mirror.descendant("body") as? Data)
        
        XCTAssertEqual(body, data)
        
    }
    
    func test_connect_withWrongURL_shouldReturnInvalidURLError() async {
        
        let sut = HttpRequest("")
        sut.urlSession = MockURLSession(.invalidUrl)
        let expectation = expectation(description: "expect invalid url error")
        
        do {
            let _ = try await sut.connect()
        } catch {
            XCTAssertEqual(error as! HttpError, .invalidUrl)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func test_connect_withoutNetworkConexion_shouldReturnNoNetworkError() async {
        
        let sut = HttpRequest(urlTest)
        sut.urlSession = MockURLSession(nil, statusCode: 500)
        sut.networkConexion = false
        let expectation = expectation(description: "expect no network error")
        
        do {
            let _ = try await sut.connect()
        } catch {
            XCTAssertEqual(error as! HttpError, .noNetworkError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func test_connect_withWrongResponse_shouldReturnUnknownNetworkError() async {
        
        let sut = HttpRequest(urlTest)
        sut.urlSession = MockURLSession(nil, statusCode: 500)
        let expectation = expectation(description: "expect network error")
        
        do {
            let _ = try await sut.connect()
        } catch {
            XCTAssertEqual(error as! HttpError, .unknownNetworkError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func test_connect_withURL_withCode200_shouldReturnResponse() async throws {
        
        let responseData = json.data(using: .utf8)
        let sut = HttpRequest(urlTest)
        sut.urlSession = MockURLSession(responseData, statusCode: 200)
        let response = try await sut.connect()
        
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.rawData, responseData)
        
    }
    
    // MARK: - Helpers
    let json = """
{
    "data": "test"
}
"""
    
}
