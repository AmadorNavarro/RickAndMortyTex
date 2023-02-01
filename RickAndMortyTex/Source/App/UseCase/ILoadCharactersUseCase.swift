protocol ILoadCharactersUseCase {
    
    func execute(page: Int) async throws -> ([Character], Bool)
    
}
