import UIKit

extension UIButton {
    
    func setContentEdgeInsets(_ insets: UIEdgeInsets) {
        
        var configuration = configuration ?? UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: insets.top,
                                                              leading: insets.left,
                                                              bottom: insets.bottom,
                                                              trailing: insets.right)
        self.configuration = configuration
        
    }
    
    func setTitle(_ text: String, font: UIFont, color: UIColor = .n70) {
        
        var configuration = configuration ?? UIButton.Configuration.plain()
        let attributes = AttributeContainer([.font : font, .foregroundColor : color])
        let title = AttributedString(text, attributes: attributes)
        configuration.attributedTitle = title
        self.configuration = configuration
        
    }
    
}
