import XCTest
@testable import RickAndMortyTex

final class LoadCharactersUseCaseTests: XCTestCase {

    var sut: LoadCharactersUseCase!
    var repository: MockCharactersRepository!

    override func setUp() {
        super.setUp()
        repository = MockCharactersRepository()
        sut = LoadCharactersUseCase(repository)
    }

    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }

    func test_execute_withPage1_shouldReturnCharacterArrayAndHasMorePages() async throws {
        
        // Preconditions
        repository.data = characters()
        repository.hasMorePages = true
        
        let (results, hasMore) = try await sut.execute(page: 1)
        
        XCTAssertEqual(results.count, 20)
        XCTAssertTrue(hasMore)
        
    }
    
    func test_getCharacters_withPage2_shouldReturnCharacterArrayAndHasNotMorePages() async throws {

        // Preconditions
        repository.data = characters()
        repository.hasMorePages = false

        let (results, hasMore) = try await sut.execute(page: 2)

        XCTAssertEqual(results.count, 20)
        XCTAssertFalse(hasMore)

    }

    func test_getCharacters_WithError_shouldThrowCharacterListError() async {

        repository.throwError = .characterListError
        let expectation = expectation(description: "throwing character list error")

        do {
            let _ = try await sut.execute(page: 1)
        } catch {
            XCTAssertEqual(error as! HttpError, .characterListError)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

    }
    
    // MARK: - Helpers
    func characters() -> [Character] {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let data = FileLoader().loadFile(name: "CharacterList")
        return try! decoder.decode(CharactersResponse.self, from: data).results
        
    }
 
}
