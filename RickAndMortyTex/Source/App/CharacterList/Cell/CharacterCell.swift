import UIKit
import Kingfisher

final class CharacterCell: UICollectionViewCell {
    
    // MARK: UI
    private(set) lazy var ui: Ui = { Ui(self.contentView) }()
    
    // MARK: LifeCycle
    override func prepareForReuse() {
        ui.imageView.image = nil
        ui.nameLabel.text = nil
        ui.spinner.startSpinning()
    }
    
    // MARK: Public methods
    func configure(name: String, imagePath: String) {
        
        ui.nameLabel.text = name
        guard let imageURL = URL(string: imagePath) else { return }
        
        ui.spinner.isHidden = false
        ui.imageView.kf.setImage(with: imageURL) { [weak self] _ in
            self?.ui.spinner.stopAnimating()
            self?.ui.spinner.isHidden = true
        }
        
    }
    
}
