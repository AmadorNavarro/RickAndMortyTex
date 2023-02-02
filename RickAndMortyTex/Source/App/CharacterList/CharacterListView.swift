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
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Common_nav_bar_title".localized
        navigationItem.backButtonTitle = ""
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ui.collectionView.dataSource = self
        ui.collectionView.delegate = self
        Task { await output.onLoadNextPage() }
    }
    
    // MARK: Public interface
    func bindInput(_ input: CharacterListModel) {
        
        sink(input.$error, input.$currentPage) { [weak self] (error, page) in
            
            if error != nil && page == 0 {
                self?.ui.errorView.showError()
            } else {
                self?.ui.errorView.isHidden = true
            }
            
        }
        
        sink(input.$characters) { [weak self] characters in
            self?.characters = characters
            self?.ui.collectionView.reloadData()
        }
        
        sink(input.$loadingPage, input.$currentPage) { [weak self] (loading, page) in
            
            if loading && page == 0 {
                self?.ui.errorView.startLoading()
            } else {
                self?.ui.spinner.isHidden = !loading
            }
            
        }
        
    }
    
    func bindOutput(_ output: CharacterListInput) {
        
        ui.errorView.tryAgaingAction {
            Task { await output.onLoadNextPage() }
        }
        
    }
    
}

extension CharacterListView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Filter indexpath to obtain the last
        let index = ui.collectionView.indexPathsForVisibleItems
            .map { $0.row }
            .sorted()
            .last
        
        if let index = index, index + 5 > characters.count {
            Task { await output.onLoadNextPage() }
        }
        
    }
    
}

extension CharacterListView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ui.cellIdentifier, for: indexPath) as? CharacterCell
        guard let cell = cell else {
            return UICollectionViewCell()
        }
        
        let character = characters[indexPath.item]
        cell.configure(name: character.name, imagePath: character.image)
        return cell
        
    }
    
}

extension CharacterListView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        output.onCharacterSelected(character)
    }
    
}
