import UIKit

extension UIColor {
    
    enum Color: String {
        
        case n30
        
        var color: UIColor {
            return UIColor(named: rawValue) ?? .yellow
        }
        
    }
    
    @nonobjc class var n30: UIColor { Color.n30.color }
    
}
