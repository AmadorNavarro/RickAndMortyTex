import XCTest
@testable import RickAndMortyTex

final class CharacterCell_UiTests: XCTestCase {

    var view: CharacterCell!
    var sut: CharacterCell.Ui!

    override func setUp() {
        super.setUp()
        view = CharacterCell()
        sut = view.ui
    }

    override func tearDown() {
        view = nil
        sut = nil
        super.tearDown()
    }

    func test_view_shouldLoadAllComponents() {

        XCTAssertNotNil(sut.shadowView)
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.gradient)
        XCTAssertNotNil(sut.nameLabel)
        XCTAssertNotNil(sut.spinner)
        
    }
    
    func test_shadowView_shouldBeCorrectlyConfigurate() {
        
        XCTAssertEqual(sut.shadowView.backgroundColor, .n30)
        XCTAssertEqual(sut.shadowView.layer.cornerRadius, 8)
        XCTAssertEqual(sut.shadowView.layer.shadowOffset, .zero)
        XCTAssertEqual(sut.shadowView.layer.shadowColor, UIColor.black.cgColor)
        XCTAssertEqual(sut.shadowView.layer.shadowOpacity, 0.2)
        XCTAssertEqual(sut.shadowView.layer.shadowRadius, 8)
        
    }
    
    func test_imageView_shouldBeCorrectlyConfigurate() {
        
        XCTAssertEqual(sut.imageView.backgroundColor, .n30)
        XCTAssertEqual(sut.imageView.contentMode, .scaleAspectFill)
        XCTAssertEqual(sut.imageView.layer.cornerRadius, 8)
        XCTAssertTrue(sut.imageView.layer.masksToBounds)
        
    }
    
    func test_nameLabel_shouldBeCorrectlyConfigurate() {
        
        XCTAssertEqual(sut.nameLabel.textColor, .white)
        XCTAssertEqual(sut.nameLabel.font, .headline1)
        XCTAssertEqual(sut.nameLabel.textAlignment, .right)
        XCTAssertEqual(sut.nameLabel.numberOfLines, 0)
        
    }
    
    func test_spinner_shouldBeCorrectlyConfigurate() {
        XCTAssertEqual(sut.spinner.contentMode, .scaleAspectFit)
        XCTAssertEqual(sut.spinner.image, Image.spinner.image(color: .white))
        XCTAssertTrue(sut.spinner.isHidden)
    }

}
