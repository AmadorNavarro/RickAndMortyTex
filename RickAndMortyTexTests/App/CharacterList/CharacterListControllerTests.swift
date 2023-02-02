import XCTest
@testable import RickAndMortyTex

final class CharacterListControllerTests: XCTestCase {

    var model: CharacterListModel!
    var useCase: MockLoadCharactersUseCase!
    var sut: CharacterListController!

    override func setUp() {
        
        super.setUp()
        model = CharacterListModel()
        useCase = MockLoadCharactersUseCase()
        sut = CharacterListController(model: model, useCase)
        
    }

    override func tearDown() {
        
        sut = nil
        model = nil
        useCase = nil
        super.tearDown()
        
    }

    func test_init_shouldSetModelAndUseCase() {
        
        let mirror = Mirror(reflecting: sut!)
        XCTAssertNotNil(mirror.descendant("model") as? CharacterListModel)
        XCTAssertNotNil(mirror.descendant("useCase") as? MockLoadCharactersUseCase)
        
    }
    
    func test_loadNextPage_shouldLoad20Characters() async {
        
        useCase.hasMorePages = true
        useCase.characters = characters()
        await sut.onLoadNextPage()
        assertCharactersValue()
        await waitForExpectations(timeout: 1)
        
        XCTAssertEqual(model.characters.count, 20)
        XCTAssertTrue(model.hasMorePages)
        
    }
    
    func test_loadTwoPages_shouldLoad40Characters() async {
        
        useCase.hasMorePages = true
        useCase.characters = characters()
        await sut.onLoadNextPage()
        await sut.onLoadNextPage()
        assertCharactersValue()
        await waitForExpectations(timeout: 1)
        
        XCTAssertEqual(model.characters.count, 40)
        XCTAssertTrue(model.hasMorePages)
        
    }
    
    func test_loadLastPage_shouldReceiveHasMorePagesFalse() async {
        
        useCase.hasMorePages = false
        useCase.characters = characters()
        await sut.onLoadNextPage()
        assertCharactersValue()
        await waitForExpectations(timeout: 1)
        
        XCTAssertFalse(model.hasMorePages)
        
    }
    
    func test_loadNextPage_withError_shouldSaveError() async {
        
        useCase.error = .characterListError
        await sut.onLoadNextPage()
        assertErrorValue()
        await waitForExpectations(timeout: 1)
        
        XCTAssertEqual(model.error, .characterListError)
        
    }
    
    func test_loadNextPage_withIsLoadingTrue_shouldNotExecuteUseCase() async {
        
        model.loadingPage = true
        await sut.onLoadNextPage()
        XCTAssertFalse(useCase.hasBeenExecuted)
        
    }
    
    func test_loadNextPage_withHasMorePagesFalse_shouldNotExecuteUseCase() async {
        
        model.hasMorePages = false
        await sut.onLoadNextPage()
        XCTAssertFalse(useCase.hasBeenExecuted)
        
    }
    
    // MARK: - Helper
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

extension CharacterListControllerTests: BindableView {
    
    func assertCharactersValue() {
        
        let expectation = expectation(description: "assert characters")
        
        sink(model.$characters) { _ in
            expectation.fulfill()
        }
        
    }
    
    func assertErrorValue() {
        
        let expectation = expectation(description: "assert characters")
        
        sink(model.$error) { _ in
            expectation.fulfill()
        }
        
    }
    
}
