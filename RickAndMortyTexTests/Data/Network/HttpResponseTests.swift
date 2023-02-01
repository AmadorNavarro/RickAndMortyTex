import XCTest
@testable import RickAndMortyTex

final class HttpResponseTests: XCTestCase {

    func test_ok_withResponseWithCode200_shouldReturnTrue() {
        let sut = HttpResponse(200, nil)
        XCTAssertTrue(sut.ok())
    }
    
    func test_ok_withResponseWithCode400_shouldReturnFalse() {
        let sut = HttpResponse(400, nil)
        XCTAssertFalse(sut.ok())
    }
    
    func test_status_ok_withCode200_shouldReturnTrue() {
        let sut = HttpResponse(200, nil)
        XCTAssertTrue(sut.status(.ok))
    }
    
    func test_status_ok_withCode400_shouldReturnFalse() {
        let sut = HttpResponse(400, nil)
        XCTAssertFalse(sut.status(.ok))
    }
    
    func test_status_badRequest_withCode400_shouldReturnTrue() {
        let sut = HttpResponse(400, nil)
        XCTAssertTrue(sut.status(.badRequest))
    }
    
    func test_status_badRequest_withCode200_shouldReturnFalse() {
        let sut = HttpResponse(200, nil)
        XCTAssertFalse(sut.status(.badRequest))
    }
    
    func test_ifOk_withCode200_shouldReturnSelf() {
        let sut = HttpResponse(200, nil)
        XCTAssertNotNil(sut.ifOk())
    }
    
    func test_ifOk_withCode400_shouldReturnNil() {
        let sut = HttpResponse(400, nil)
        XCTAssertNil(sut.ifOk())
    }
    
    func test_as_withCorrectModel_shouldReturnModel() throws {
        
        struct Response: Decodable {
            var data: String
        }
        
        let sut = HttpResponse(200, json.data(using: .utf8))
        let response = try XCTUnwrap(sut.as(Response.self))
        
        XCTAssertEqual(response.data, "test")
        
    }
    
    func test_as_withIncorrectModel_shouldReturnNil() {
        
        struct Response: Decodable {
            var wrongModel: String
        }
        
        let sut = HttpResponse(200, json.data(using: .utf8))
        
        XCTAssertNil(sut.as(Response.self))
        
    }
    
    // MARK: - Helpers
    let json = """
{
    "data": "test"
}
"""

}
