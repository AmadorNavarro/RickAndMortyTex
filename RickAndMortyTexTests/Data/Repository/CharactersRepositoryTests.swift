import XCTest
@testable import RickAndMortyTex

final class CharactersRepositoryTests: XCTestCase {

    var sut: CharactersRepository!
    var requestFactory: MockRequestFactory!

    override func setUp() {
        super.setUp()
        requestFactory = MockRequestFactory()
        sut = CharactersRepository(requestFactory)
    }

    override func tearDown() {
        sut = nil
        requestFactory = nil
        super.tearDown()
    }

    func test_getCharacters_withPage1_shouldReturnCharacterArrayAndHasMorePages() async throws {
        
        requestFactory.data = jsonResponse.data(using: .utf8)!
        let (results, hasMore) = try await sut.getCharacters(page: 1)
        
        XCTAssertEqual(results.count, 1)
        XCTAssertTrue(hasMore)
        
    }
    
    func test_getCharacters_withPage2_shouldReturnCharacterArrayAndHasNotMorePages() async throws {
        
        requestFactory.data = jsonResponse.data(using: .utf8)!
        let (results, hasMore) = try await sut.getCharacters(page: 2)
        
        XCTAssertEqual(results.count, 1)
        XCTAssertFalse(hasMore)
        
    }
    
    func test_getCharacters_WithError_shouldThrowCharacterListError() async {
        
        requestFactory.throwError = .characterListError
        let expectation = expectation(description: "throwing character list error")
        
        do {
            let _ = try await sut.getCharacters(page: 1)
        } catch {
            XCTAssertEqual(error as! HttpError, .characterListError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    // MARK: - Helpers
    let jsonResponse = """
{
    "info": {
        "count": 826,
        "pages": 2,
        "next": "https://rickandmortyapi.com/api/character?page=2",
        "prev": null
    },
    "results": [{
        "id": 1,
        "name": "Rick Sanchez",
        "status": "Alive",
        "species": "Human",
        "type": "",
        "gender": "Male",
        "origin": {
            "name": "Earth (C-137)",
            "url": "https://rickandmortyapi.com/api/location/1"
        },
        "location": {
            "name": "Citadel of Ricks",
            "url": "https://rickandmortyapi.com/api/location/3"
        },
        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        "episode": ["https://rickandmortyapi.com/api/episode/1"],
        "url": "https://rickandmortyapi.com/api/character/1",
        "created": "2017-11-04T18:48:46.250Z"
    }]
}
"""

}
