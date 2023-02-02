import XCTest
@testable import RickAndMortyTex

final class CharacterControllerTests: XCTestCase {

    var model: CharacterModel!
    var navigator: BaseMockAppNavigator!
    var sut: CharacterController!

    override func setUp() {
        super.setUp()
        model = CharacterModel()
        navigator = BaseMockAppNavigator()
        sut = CharacterController(model: model, navigator)
    }

    override func tearDown() {
        sut = nil
        model = nil
        navigator = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in CharacterControllerTests")
    }

}
