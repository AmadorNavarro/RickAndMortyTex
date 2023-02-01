import UIKit

final class CharacterListView: UIViewController, BindableView {
    
    // MARK: Private members
    private(set) lazy var ui = { Ui(self.view) }()
    private let output: CharacterListInput
    
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
        
    }
    
    func bindOutput(_ output: CharacterListInput) {
        
    }
    
}
