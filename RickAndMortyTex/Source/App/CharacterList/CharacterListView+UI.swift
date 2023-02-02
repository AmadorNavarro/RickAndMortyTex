import UIKit

private let collectionCellSize = CGSize(width: 200, height: 250)

extension CharacterListView { final class Ui {
    
    let cellIdentifier = "CharacterCell"
    lazy var collectionView: UICollectionView = self.createCollectionView()
    let spinner = UIImageView()
    let errorView = ErrorEmptyView()
    let noNetworkView = NoNetworkView()
        
    init(_ superview: UIView) {
        
        superview.backgroundColor = .white
        
        // bottom spinner
        superview.configure(spinner) {
            
            $0.contentMode = .scaleAspectFit
            $0.image = Image.spinner.image(color: .n70)
            $0.startSpinning()
            $0.isHidden = true
            
            $1.centerX.equalToSuperview()
            $1.bottom.equalTo(superview.safeAreaLayoutGuide)
            $1.width.height.equalTo(40)
            
        }
        
        // Collection view
        superview.configure(collectionView) {
            
            $0.backgroundColor = .clear
            $0.accessibilityId(.characterList)
            $0.register(CharacterCell.self, forCellWithReuseIdentifier: cellIdentifier)
            
            $1.edges.equalToSuperview()
            
        }
        
        // Error view
        superview.configure(errorView) {
            $1.center.equalToSuperview()
        }
        
        // No connection view
        superview.configure(noNetworkView) {
            $1.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    // MARK: Private methods
    private func createCollectionView() -> UICollectionView {
        
        let width = UIScreen.main.bounds.width / 2
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: 250)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }
    
} }
