import class UIKit.UIView
import SnapKit

extension UIView {
    
    func configure<T : UIView>(_ subview: T, autoAdd: Bool = true,  _ closure: (T, ConstraintMaker) -> Void) {
        
        if autoAdd {
            addSubview(subview)
        }

        subview.snp.makeConstraints {
            closure(subview, $0)
        }
        
    }
    
}
