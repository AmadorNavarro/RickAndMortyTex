import Resolver

extension CharacterListView { class Factory {
        
    func create() -> CharacterListView {
            
        let model = CharacterListModel()
        let controller = CharacterListController(model: model, Resolver.resolve(), Resolver.resolve())
        let view = CharacterListView(input: model, output: controller)
            
        return view
            
    }
        
} }
