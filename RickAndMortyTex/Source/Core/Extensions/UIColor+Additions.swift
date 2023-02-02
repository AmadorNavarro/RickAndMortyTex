import UIKit

extension UIColor {
    
    enum Color: String {
        
        case n30
        case n70
        case danger
        
        var color: UIColor {
            return UIColor(named: rawValue) ?? .yellow
        }
        
    }
    
    @nonobjc class var n30: UIColor { Color.n30.color }
    @nonobjc class var n70: UIColor { Color.n70.color }
    @nonobjc class var danger: UIColor { Color.danger.color }
    
}
