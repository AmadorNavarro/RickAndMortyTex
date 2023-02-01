import UIKit

private let collectionCellSize = CGSize(width: 200, height: 250)

extension CharacterListView { final class Ui {
    
    lazy var collectionView: UICollectionView = self.createCollectionView()
        
    init(_ superview: UIView) {
        
        superview.configure(collectionView) {
            $0.backgroundColor = .white
            $1.edges.equalToSuperview()
        }
        
    }
        
    func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 14
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionCellSize
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
        
    }
    
} }
