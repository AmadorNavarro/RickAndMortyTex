import UIKit

extension UIApplication {
    
    class func rootViewController() -> UIViewController? {
        let scene = shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first(where: { $0.isKeyWindow })?.rootViewController
    }
    
    class func getVisibleViewController(base: UIViewController? = nil) -> UIViewController? {
        
        let base = base ?? rootViewController()
        
        if let nav = base as? UINavigationController {
            return getVisibleViewController(base: nav.visibleViewController)
        } else if let presented = base?.presentedViewController {
            return getVisibleViewController(base: presented)
        }
        
        return base
        
    }
    
}
