import UIKit

class BindableGestureRecognizer: UITapGestureRecognizer, UIGestureRecognizerDelegate {
    
    private var action: () -> Void

    init(action: @escaping () -> Void, overwriteExisting: Bool) {
        
        self.action = action
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(execute))
        
        if !overwriteExisting {
            self.delegate = self
        }
        
    }

    @objc func execute() {
        action()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
}
