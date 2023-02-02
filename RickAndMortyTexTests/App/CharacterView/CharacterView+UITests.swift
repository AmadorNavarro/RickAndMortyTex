import XCTest
@testable import RickAndMortyTex

final class CharacterView_UiTests: XCTestCase {

    var view: CharacterView!
    var sut: CharacterView.Ui!

    override func setUp() {
        super.setUp()
        view = CharacterView.Factory().create()
        sut = view.ui
    }

    override func tearDown() {
        view = nil
        sut = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in CharacterView_UiTests")
    }

    func test_view_shouldLoadAllComponents() {

    }

}

