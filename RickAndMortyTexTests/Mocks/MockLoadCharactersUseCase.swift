@testable import RickAndMortyTex

final class MockLoadCharactersUseCase: ILoadCharactersUseCase {
    
    var error: HttpError?
    var characters: [Character] = []
    var hasMorePages = false
    var hasBeenExecuted = false

    func execute(page: Int) async throws -> ([Character], Bool) {
        
        hasBeenExecuted = true
        if let error = error {
            throw error
        }
        
        return (characters, hasMorePages)
        
    }
    
}
