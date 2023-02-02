import UIKit
import Network
import SnapKit

private let viewHeight = 42.0
private let hideTransform = CGAffineTransform(translationX: 0, y: viewHeight)

class NoNetworkView: UIView {
    
    // MARK: Private members
    private let label = UILabel()
    private let monitor = NWPathMonitor()
    private(set) var connected = true
    var bottomConstraint: Constraint?
    var bottomPad: CGFloat = 0.0

    // MARK: Overridden members
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width, height: viewHeight)
    }
    
    // MARK: Initializers
    init() {
        
        super.init(frame: .zero)
        backgroundColor = .danger
        isHidden = true
        transform = hideTransform
        
        configure(label) {
            
            $0.text = "common_error_no_internet".localized
            $0.textColor = .white
            $0.font = .subtitle1
            $0.textAlignment = .center

            $1.leading.trailing.centerY.equalToSuperview()

        }
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.update(path.status)
        }
        
        monitor.start(queue: DispatchQueue.main)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        monitor.cancel()
    }
    
    // MARK: Private members
    private func update(_ status: NWPath.Status) {
        
        if status == .satisfied {

            if !connected {
                connected = true
                hide()
            }

        } else if connected {
            connected = false
            show()
        }
        
    }
    
    private func show() {
        
        isHidden = false
        transform = hideTransform

        UIView.animate(withDuration: 1, delay: 0) { [weak self] in
            self?.transform = .identity
        }

    }
    
    private func hide() {
        
        isHidden = false
        transform = .identity
        
        UIView.animate(withDuration: 1, delay: 0, animations: { [weak self] in
            self?.transform = hideTransform
        }) { [weak self] _ in
            self?.isHidden = true
        }

    }
    
}
