protocol ICharactersRepository {
    
    func getCharacters(page: Int) async throws -> ([Character], Bool)
    
}
