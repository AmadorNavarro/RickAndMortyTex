import UIKit

@dynamicMemberLookup
enum Font: String {

    static let defaultSizeFont = 5

    case black = "NotoSans-Black"
    case schwifty = "get_schwifty"

    subscript(dynamicMember size: String) -> UIFont {
        let size = CGFloat(Int(size) ?? Font.defaultSizeFont)
        return UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }

}

extension UIFont {
    
    @nonobjc class var rickAndMorty: UIFont { Font.schwifty.32 }
    @nonobjc class var headline1: UIFont { Font.black.24 }
    
}
