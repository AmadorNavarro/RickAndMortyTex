import UIKit

extension UIImageView {
    
    func startSpinning() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue =  Double.pi * 2.0
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: "spin")
        
    }
    
    func stopSpinning() {
        layer.removeAnimation(forKey: "spin")
    }
    
}
