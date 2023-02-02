import UIKit

final class ErrorEmptyView: UIView {

    // MARK: Private members
    private(set) lazy var ui = { Ui(self) }()
    

    // MARK: Initializers
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tryAgaingAction(_ action: @escaping (() -> Void)) {
        ui.button.onTap {
            action()
        }
    }
    
    func startLoading() {
        isHidden = false
        ui.spinner.isHidden = false
        ui.loadingLabel.isHidden = false
        ui.titleLabel.isHidden = true
        ui.imageView.isHidden = true
        ui.button.isHidden = true
    }
    
    func showError() {
        isHidden = false
        ui.spinner.isHidden = true
        ui.loadingLabel.isHidden = true
        ui.titleLabel.isHidden = false
        ui.imageView.isHidden = false
        ui.button.isHidden = false
    }
    
}
