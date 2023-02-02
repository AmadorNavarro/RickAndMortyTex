import XCTest
@testable import RickAndMortyTex

final class CharacterCellTests: XCTestCase {

    func test_configure_shouldConfigureLabel() {
        let sut = CharacterCell()
        sut.configure(name: "NameTest", imagePath: "")
        XCTAssertEqual(sut.ui.nameLabel.text, "NameTest")
    }

}
