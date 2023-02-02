protocol CharacterListInput {
    
    /// Load characters and update current page
    func onLoadNextPage() async
    
    /// Navigate to the charcter detail view
    func onCharacterSelected(_ character: Character)
    
}
