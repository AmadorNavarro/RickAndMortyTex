import XCTest
@testable import RickAndMortyTex

final class CharacterViewTests: XCTestCase {

    var model: CharacterModel!
    var controller: MockCharacterController! 
    var sut: CharacterView!

    override func setUp() {
        super.setUp()
        model = CharacterModel()
        controller = MockCharacterController()
        sut = CharacterView(input: model, output: controller)
    }

    override func tearDown() {
        sut = nil
        model = nil
        controller = nil
        super.tearDown()
    }

    func test_zero() {
        XCTFail("Tests not yet implemented in CharacterViewTests")
    }

}
