final class CharactersRepository: ICharactersRepository {
    
    let requestFactory: IRequestFactory
    
    init(_ requestFactory: IRequestFactory) {
        self.requestFactory = requestFactory
    }
    
    func getCharacters(page: Int) async throws -> ([Character], Bool) {
        
        let response = try await requestFactory
            .create(path: APIConstants.character, parameters: ["page" : String(page)])
            .connect()
        
        let characters = try response.ifOk()?.as(CharactersResponse.self) ?? { throw HttpError.characterListError }()
        return (characters.results, page < characters.pages)
        
    }
    
}
