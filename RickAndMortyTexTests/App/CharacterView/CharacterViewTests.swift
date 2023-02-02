import XCTest
@testable import RickAndMortyTex

final class CharacterViewTests: XCTestCase {

    var model: CharacterModel!
    var sut: CharacterView!

    override func setUp() {
        super.setUp()
        model = CharacterModel(character())
        sut = CharacterView(input: model)
    }

    override func tearDown() {
        sut = nil
        model = nil
        super.tearDown()
    }

    // Bind input
    func test_bindCharacter_shouldUpdatedUi() {
        
        assertCharacter()
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.ui.nameLabel.text, "Rick Sanchez")
        
    }
    
    func test_configureCharacter_shouldUpdatedUi() {
        
        assertCharacter()
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.ui.nameLabel.text, "Rick Sanchez")
        XCTAssertEqual(sut.ui.statusValue.text, "Alive".localized)
        XCTAssertEqual(sut.ui.speciesValue.text, "Human")
        XCTAssertEqual(sut.ui.genderValue.text, "Male".localized)
        XCTAssertEqual(sut.ui.createdValue.text, "sáb, 4 noviembre 2017")
        
    }
    
    // MARK: - Helpers
    private func character() -> Character {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let data = FileLoader().loadFile(name: "CharacterList")
        return try! decoder.decode(CharactersResponse.self, from: data).results.first!
        
    }

}

extension CharacterViewTests: BindableView {
    
    func assertCharacter() {
        
        let expectation = expectation(description: "assert character")
        
        sink(model.$character) { _ in
            expectation.fulfill()
        }
        
    }
    
}
