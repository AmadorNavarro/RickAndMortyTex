import Resolver

extension CharacterView { class Factory {
        
    func create(character: Character) -> CharacterView {
            
        let model = CharacterModel(character)
        let view = CharacterView(input: model)
            
        return view
            
    }
        
} }
