import XCTest
@testable import RickAndMortyTex

final class RequestFactoryTests: XCTestCase {

    func test_create_withPath_shouldReturnRequestWithBaseURLPlusPath() throws {
        
        let sut = RequestFactory().create(path: APIConstants.character)
        let mirror = Mirror(reflecting: sut)
        let url = try XCTUnwrap(mirror.descendant("url") as? String)
        
        XCTAssertEqual(url, "https://rickandmortyapi.com/api/character")
        
    }
    
    func test_create_withPath_andParameters_shouldReturnRequestWithBaseURLPlusPathPlusParameters() throws {
        
        let sut = RequestFactory().create(path: APIConstants.character, parameters: ["page" : "1"])
        let mirror = Mirror(reflecting: sut)
        let url = try XCTUnwrap(mirror.descendant("url") as? String)
        
        XCTAssertEqual(url, "https://rickandmortyapi.com/api/character?page=1")
        
    }

}
