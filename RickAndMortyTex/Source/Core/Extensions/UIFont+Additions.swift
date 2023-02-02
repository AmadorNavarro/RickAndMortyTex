import UIKit

@dynamicMemberLookup
enum Font: String {

    static let defaultSizeFont = 5

    case black = "NotoSans-Black"
    case semiBold = "NotoSans-SemiBold"
    case regular = "NotoSans-Regular"
    case medium = "NotoSans-Medium"
    case schwifty = "Get Schwifty"

    subscript(dynamicMember size: String) -> UIFont {
        let size = CGFloat(Int(size) ?? Font.defaultSizeFont)
        return UIFont(name: rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }

}

extension UIFont {
    
    @nonobjc class var rickAndMorty: UIFont { Font.schwifty.32 }
    @nonobjc class var headline1: UIFont { Font.black.24 }
    @nonobjc class var headline2: UIFont { Font.black.16 }
    @nonobjc class var headline3: UIFont { Font.semiBold.16 }
    @nonobjc class var body1: UIFont { Font.regular.14 }
    @nonobjc class var subtitle1: UIFont { Font.semiBold.14 }
    @nonobjc class var buttonText1: UIFont { Font.medium.12 }
    
}
