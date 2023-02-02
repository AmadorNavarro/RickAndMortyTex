final class CharacterListController {
    
    // MARK: Dependencies
    private let useCase: ILoadCharactersUseCase
    private let appNavigator: IAppNavigator
    
    // MARK: Private members
    private let model: CharacterListModel
    private var isLoading = false
    
    // MARK: Initializers
    init(model: CharacterListModel, _ useCase: ILoadCharactersUseCase, _ appNavigator: IAppNavigator) {
        self.model = model
        self.useCase = useCase
        self.appNavigator = appNavigator
    }
    
    // MARK: Private methods
    private func loadNextPage() async {
        
        guard !model.loadingPage && model.hasMorePages else { return }
        
        model.loadingPage = true
        let page = model.currentPage + 1
        
        do {
            let (results, hasMorePages) =  try await useCase.execute(page: page)
            model.characters.append(contentsOf: results)
            model.hasMorePages = hasMorePages
            model.currentPage = page
        } catch {
            let error = (error as? HttpError) ?? HttpError.unknownNetworkError
            model.error = error
        }
        
        model.loadingPage = false
        
    }
    
}

extension CharacterListController: CharacterListInput {
    
    func onLoadNextPage() async {
        await loadNextPage()
    }
    
    func onCharacterSelected(_ character: Character) {
        appNavigator.toCharacterDetailView(character)
    }
    
}
