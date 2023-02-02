import XCTest
@testable import RickAndMortyTex

final class MockCharacterListController: CharacterListInput {
    
    var isLoadNextPageCalled = false
    
    func onLoadNextPage() {
        isLoadNextPageCalled = true
    }
    
}
