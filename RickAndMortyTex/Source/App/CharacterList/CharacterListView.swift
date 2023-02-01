import UIKit

final class CharacterListView: UIViewController, BindableView {
    
    // MARK: Private members
    private(set) lazy var ui = { Ui(self.view) }()
    private let output: CharacterListInput
    private var characters: [Character] = []
    
    // MARK: Initializer
    init(input: CharacterListModel, output: CharacterListInput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        bindInput(input)
        bindOutput(output)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public interface
    func bindInput(_ input: CharacterListModel) {
        
        sink(input.$characters) { [weak self] characters in
            self?.characters = characters
            self?.ui.collectionView.reloadData()
        }
        
    }
    
    func bindOutput(_ output: CharacterListInput) {
        
    }
    
}
