import UIKit

final class NavigationView: UINavigationController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .darkSky
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        navBarAppearance.backgroundImage = UIImage()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.greenText,
                                                NSAttributedString.Key.font : UIFont.rickAndMorty]
        
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        
    }
    
}
