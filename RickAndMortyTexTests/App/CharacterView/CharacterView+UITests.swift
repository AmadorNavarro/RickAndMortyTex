import XCTest
@testable import RickAndMortyTex

final class CharacterView_UiTests: XCTestCase {

    var view: CharacterView!
    var sut: CharacterView.Ui!

    override func setUp() {
        super.setUp()
        view = CharacterView.Factory().create(character: character())
        sut = view.ui
    }

    override func tearDown() {
        view = nil
        sut = nil
        super.tearDown()
    }

    func test_view_shouldLoadAllComponents() {
        
        XCTAssertNotNil(sut.background)
        XCTAssertNotNil(sut.nameLabel)
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.statusKey)
        XCTAssertNotNil(sut.statusValue)
        XCTAssertNotNil(sut.speciesKey)
        XCTAssertNotNil(sut.speciesValue)
        XCTAssertNotNil(sut.genderKey)
        XCTAssertNotNil(sut.genderValue)
        XCTAssertNotNil(sut.createdKey)
        XCTAssertNotNil(sut.createdValue)
        
    }
    
    func test_background_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.background.contentMode, .scaleAspectFill)
        XCTAssertEqual((sut.background.alpha * 100).rounded() / 100, 0.2)  // accurate alpha decimals
    }
    
    func test_imageView_shouldBeCorrectlyConfigurate() {
        
        XCTAssertEqual(sut.imageView.contentMode, .scaleAspectFit)
        XCTAssertTrue(sut.imageView.layer.masksToBounds)
        XCTAssertEqual(sut.imageView.layer.borderColor, UIColor.n70.cgColor)
        XCTAssertEqual(sut.imageView.layer.borderWidth, 2)
        XCTAssertEqual(sut.imageView.layer.cornerRadius, 12)
        
    }
    
    func test_nameLabel_shouldBeCorrectlyConfigurate() {
        
        XCTAssertEqual(sut.nameLabel.font, .headline1)
        XCTAssertEqual(sut.nameLabel.textColor, .n70)
        XCTAssertEqual(sut.nameLabel.textAlignment, .center)
        XCTAssertEqual(sut.nameLabel.numberOfLines, 0)
        
    }
    
    func test_statusKey_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.statusKey.text, "character_view_status".localized)
        XCTAssertEqual(sut.statusKey.font, .headline3)
        XCTAssertEqual(sut.statusKey.textColor, .n70)
    }
    
    func test_statusValue_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.statusValue.font, .headline2)
        XCTAssertEqual(sut.statusValue.textColor, .n70)
    }
    
    func test_speciesKey_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.speciesKey.text, "character_view_species".localized)
        XCTAssertEqual(sut.speciesKey.font, .headline3)
        XCTAssertEqual(sut.speciesKey.textColor, .n70)
    }
    
    func test_speciesValue_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.speciesValue.font, .headline2)
        XCTAssertEqual(sut.speciesValue.textColor, .n70)
    }
    
    func test_genderKey_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.genderKey.text, "character_view_gender".localized)
        XCTAssertEqual(sut.genderKey.font, .headline3)
        XCTAssertEqual(sut.genderKey.textColor, .n70)
    }
    
    func test_genderValue_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.genderValue.font, .headline2)
        XCTAssertEqual(sut.genderValue.textColor, .n70)
    }
    
    func test_createdKey_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.createdKey.text, "character_view_created".localized)
        XCTAssertEqual(sut.createdKey.font, .headline3)
        XCTAssertEqual(sut.createdKey.textColor, .n70)
    }
    
    func test_createdValue_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.createdValue.font, .headline2)
        XCTAssertEqual(sut.createdValue.textColor, .n70)
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

