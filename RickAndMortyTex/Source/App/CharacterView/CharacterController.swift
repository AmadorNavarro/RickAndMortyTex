final class CharacterController {
    
    // MARK: Dependencies
    private let navigator: IAppNavigator
    
    // MARK: Private members
    private let model: CharacterModel
    
    // MARK: Initializers
    init(model: CharacterModel, _ navigator: IAppNavigator) {
        self.model = model
        self.navigator = navigator
    }
    
}

extension CharacterController: CharacterInput {
    
}
