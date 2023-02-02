import UIKit

// MARK: - DataSource
func itemsInSection(in collectionView: UICollectionView, section: Int) -> Int? {
    collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: section)
}

func cellForItem(in collectionView: UICollectionView, item: Int, section: Int = 0) -> UICollectionViewCell? {
    collectionView.dataSource?.collectionView(collectionView, cellForItemAt: IndexPath(item: item, section: section))
}

// MARK: - Delegate
func didSelectedItem(in collectionView: UICollectionView, item: Int, section: Int = 0) {
    collectionView.delegate?.collectionView?(collectionView,
                                             didSelectItemAt: IndexPath(item: item, section: section))
}
