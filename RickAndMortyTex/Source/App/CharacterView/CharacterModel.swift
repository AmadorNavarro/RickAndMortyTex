import Combine

final class CharacterModel {
    
    @Published var character: Character
    
    init(_ character: Character) {
        self.character = character
    }
    
}
