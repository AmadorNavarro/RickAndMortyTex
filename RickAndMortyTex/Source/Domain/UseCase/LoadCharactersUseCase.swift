final class LoadCharactersUseCase: ILoadCharactersUseCase {
    
    let repository: ICharactersRepository
    
    init(_ repository: ICharactersRepository) {
        self.repository = repository
    }
    
    func execute(_ page: Int) async throws -> ([Character], Bool) {
        try await repository.getCharacters(page: page)
    }
    
}
