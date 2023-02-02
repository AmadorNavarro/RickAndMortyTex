import XCTest
@testable import RickAndMortyTex

final class CharacterListViewTests: XCTestCase {

    var model: CharacterListModel!
    var controller: MockCharacterListController! 
    var sut: CharacterListView!

    override func setUp() {
        super.setUp()
        model = CharacterListModel()
        controller = MockCharacterListController()
        sut = CharacterListView(input: model, output: controller)
    }

    override func tearDown() {
        sut = nil
        model = nil
        controller = nil
        super.tearDown()
    }

    // MARK: life cycle
    func test_init_shouldSetOutputProperty() {
        let mirror = Mirror(reflecting: sut!)
        XCTAssertNotNil(mirror.descendant("output") as? MockCharacterListController)
    }
    
    func test_viewWillAppear_shouldSetCollectionViewDelegates() {
        sut.viewWillAppear(false)
        XCTAssertNotNil(sut.ui.collectionView.dataSource)
        XCTAssertNotNil(sut.ui.collectionView.delegate)
    }
    
    func test_viewWillAppear_shouldLoadFirstCharactersPage() {
        
        sut.viewWillAppear(false)
        assertLoadNextPageExecution()
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(controller.isLoadNextPageCalled)
        
    }
    
    // MARK: Bind input
    func test_nilErrorAndPage0_shouldLetErrorViewHidden() {
        
        model.error = nil
        model.currentPage = 0
        assertErrorValue(nil, pageValue: 0)
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(sut.ui.errorView.isHidden)
        
    }
    
    func test_characterListErrorAndPage1_shouldLetErrorViewHidden() {
        
        model.error = .characterListError
        model.currentPage = 1
        assertErrorValue(.characterListError, pageValue: 1)
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(sut.ui.errorView.isHidden)
        
    }
    
    func test_characterListErrorAndPage0_shouldShowErrorView() {
        
        model.error = .characterListError
        model.currentPage = 0
        assertErrorValue(.characterListError, pageValue: 0)
        waitForExpectations(timeout: 1)
        
        XCTAssertFalse(sut.ui.errorView.isHidden)
        XCTAssertTrue(sut.ui.errorView.ui.spinner.isHidden)
        XCTAssertTrue(sut.ui.errorView.ui.loadingLabel.isHidden)
        XCTAssertFalse(sut.ui.errorView.ui.titleLabel.isHidden)
        XCTAssertFalse(sut.ui.errorView.ui.imageView.isHidden)
        XCTAssertFalse(sut.ui.errorView.ui.button.isHidden)
        
    }
    
    func test_getNewCharacters_shouldRefreshCollectionView() {
        
        // Preconditions
        sut.viewWillAppear(false)
        XCTAssertEqual(sut.ui.collectionView.numberOfItems(inSection: 0), 0)
        
        // Add characters
        model.characters = characters()
        assertCharactersValue()
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.ui.collectionView.numberOfItems(inSection: 0), 20)
        
    }
    
    func test_loadingPageFalse_andPage0_shouldHideSpinner() {
        
        model.loadingPage = false
        model.currentPage = 0
        assertLoadingPageValue(false, pageValue: 0)
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(sut.ui.spinner.isHidden)
        
    }
    
    func test_loadingPageTrue_andPage1_shouldShowSpinner() {
        
        model.loadingPage = true
        model.currentPage = 1
        assertLoadingPageValue(true, pageValue: 1)
        waitForExpectations(timeout: 1)
        
        XCTAssertFalse(sut.ui.spinner.isHidden)
        
    }
    
    func test_loadingPageTrue_andPage0_shouldShowErrorView() {
        
        model.loadingPage = true
        model.currentPage = 0
        assertLoadingPageValue(true, pageValue: 0)
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(sut.ui.spinner.isHidden)
        XCTAssertFalse(sut.ui.errorView.ui.spinner.isHidden)
        XCTAssertFalse(sut.ui.errorView.ui.loadingLabel.isHidden)
        XCTAssertTrue(sut.ui.errorView.ui.titleLabel.isHidden)
        XCTAssertTrue(sut.ui.errorView.ui.imageView.isHidden)
        XCTAssertTrue(sut.ui.errorView.ui.button.isHidden)
        
    }
    
    // Bind output
    func test_onTapTryAgainButton_shouldLoadCharacters() {
        
        sut.ui.errorView.showError()
        tap(sut.ui.errorView.ui.button)
        assertLoadNextPageExecution()
        waitForExpectations(timeout: 1)
        
        XCTAssertTrue(controller.isLoadNextPageCalled)
        
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

extension CharacterListViewTests: BindableView {
    
    func assertErrorValue(_ errorValue: HttpError?, pageValue: Int) {
        
        let expectation = expectation(description: "assert error and page")
        
        sink(model.$error, model.$currentPage) { (error, page) in
            if error == errorValue && page == pageValue {
                expectation.fulfill()
            }
        }
        
    }
    
    func assertCharactersValue() {
        
        let expectation = expectation(description: "assert characters")
        
        sink(model.$characters) { _ in
            expectation.fulfill()
        }
        
    }
    
    func assertLoadingPageValue(_ loadingValue: Bool, pageValue: Int) {
        
        let expectation = expectation(description: "assert error and page")
        
        sink(model.$loadingPage, model.$currentPage) { (loading, page) in
            if loading == loadingValue && page == pageValue {
                expectation.fulfill()
            }
        }
        
    }
    
    func assertLoadNextPageExecution() {
        
        let expectation = expectation(description: "assert error and page")
        
        waitRunLoopUntil(1) {
            controller.isLoadNextPageCalled
        }
        
        expectation.fulfill()
        
    }
    
}
