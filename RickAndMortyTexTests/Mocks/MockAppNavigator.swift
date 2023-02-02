@testable import RickAndMortyTex

final class MockAppNavigatior: IAppNavigator {
    
    var navigatedToCharacterView = false
    
    func toCharacterDetailView(_ character: RickAndMortyTex.Character) {
        navigatedToCharacterView = true
    }
    
}
