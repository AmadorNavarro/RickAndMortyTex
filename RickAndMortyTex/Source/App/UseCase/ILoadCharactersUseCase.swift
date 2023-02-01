protocol ILoadCharactersUseCase {
    
    func execute(_ page: Int) async throws -> ([Character], Bool)
    
}
