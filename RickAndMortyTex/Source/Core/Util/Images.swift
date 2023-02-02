import UIKit

enum Image: String {
    
    case spinner
    case empty
    
    var image: UIImage {
        return image(color: nil)
    }

    func image(color: UIColor?) -> UIImage {
        
        guard var image = dynamicImage(named: rawValue) else { return UIImage() }
        
        if let color = color {
            image = image.withTintColor(color, renderingMode: .alwaysOriginal)
        }

        return image
        
    }

    func dynamicImage(named name: String) -> UIImage? {
        let asset = UIImage(named: name)?.imageAsset
        return asset?.image(with: UIScreen.main.traitCollection)
    }
    
}
