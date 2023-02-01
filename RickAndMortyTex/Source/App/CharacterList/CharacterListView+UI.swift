import UIKit

private let collectionCellSize = CGSize(width: 198, height: 264)

extension CharacterListView { final class Ui {
    
    lazy var collectionView: UICollectionView = self.createCollectionView()
        
    init(_ superview: UIView) {
        
        
        
    }
        
    func createCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 14
        layout.scrollDirection = .horizontal
        layout.itemSize = collectionCellSize
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
        
    }
    
} }
