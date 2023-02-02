import XCTest
@testable import RickAndMortyTex

final class CharacterListView_UiTests: XCTestCase {

    var view: CharacterListView!
    var sut: CharacterListView.Ui!

    override func setUp() {
        super.setUp()
        view = CharacterListView.Factory().create()
        sut = view.ui
    }

    override func tearDown() {
        view = nil
        sut = nil
        super.tearDown()
    }

    func test_view_shouldLoadAllComponents() {
        
        XCTAssertNotNil(sut.collectionView)
        XCTAssertNotNil(sut.spinner)
        XCTAssertNotNil(sut.errorView)
        XCTAssertNotNil(sut.noNetworkView)
        
    }
    
    func test_CollectionView_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.collectionView.backgroundColor, .clear)
    }
    
    func test_spinner_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.spinner.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.spinner.image, Image.spinner.image(color: .n70))
        XCTAssertTrue(sut.spinner.isHidden)
    }
    
}

