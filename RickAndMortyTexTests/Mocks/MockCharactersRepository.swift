@testable import RickAndMortyTex
import Foundation

final class MockCharactersRepository: ICharactersRepository {
    
    var throwError: HttpError?
    var data: [Character] = []
    var hasMorePages = false
    
    func getCharacters(page: Int) async throws -> ([Character], Bool) {
        
        if let error = throwError {
            throw error
        }
        
        return (data, hasMorePages)
        
    }
    
}
