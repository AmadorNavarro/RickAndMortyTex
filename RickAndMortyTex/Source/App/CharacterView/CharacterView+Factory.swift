import Resolver

extension CharacterView { class Factory {
        
    func create(character: Character) -> CharacterView {
            
        let model = CharacterModel(character)
        let controller = CharacterController(model: model, Resolver.resolve())
        let view = CharacterView(input: model, output: controller)
            
        return view
            
    }
        
} }
