import UIKit
import Kingfisher

final class CharacterView: UIViewController, BindableView {
    
    // MARK: Private members
    private(set) lazy var ui = { Ui(self.view) }()
    private let output: CharacterInput
    
    // MARK: Initializer
    init(input: CharacterModel, output: CharacterInput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        bindInput(input)
        bindOutput(output)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "Rick and Morty"
    }
    
    // MARK: Public interface
    func bindInput(_ input: CharacterModel) {
        
        sink(input.$character) { [weak self] character in
            self?.configure(character)
        }
        
    }
    
    func bindOutput(_ output: CharacterInput) {
        
    }
    
    // MARK: Public methods
    private func configure(_ character: Character) {
        
        ui.background.kf.setImage(with: URL(string: character.image))
        ui.imageView.kf.setImage(with: URL(string: character.image))
        ui.nameLabel.text = character.name
        ui.statusValue.text = character.status.rawValue.localized
        ui.speciesValue.text = character.species
        ui.genderValue.text = character.gender.rawValue.localized
        ui.createdValue.text = character.created.noTimeFormat
        
    }
    
}
