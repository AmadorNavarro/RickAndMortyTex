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
        
        requestFactory.data = FileLoader().loadFile(name: "CharacterList")
        let (results, hasMore) = try await sut.getCharacters(page: 1)
        
        XCTAssertEqual(results.count, 20)
        XCTAssertTrue(hasMore)
        
    }
    
    func test_getCharacters_withPage2_shouldReturnCharacterArrayAndHasNotMorePages() async throws {
        
        requestFactory.data = FileLoader().loadFile(name: "CharacterList")
        let (results, hasMore) = try await sut.getCharacters(page: 2)
        
        XCTAssertEqual(results.count, 20)
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

}
