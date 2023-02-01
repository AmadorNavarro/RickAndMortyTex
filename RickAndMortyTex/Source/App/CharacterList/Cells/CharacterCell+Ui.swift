import UIKit

extension CharacterCell { final class Ui {
  
    // ┌─────────────┐
    // │             │
    // │    IMAGE    │
    // │             │
    // │             │
    // │             │
    // │        NAME │
    // └─────────────┘
    
    let imageView = UIImageView()
    let gradient = UIView()
    let nameLabel = UILabel()
    let spinner = UIImageView()
    
    init(_ superview: UIView) {
        
        superview.backgroundColor = .clear
        
        superview.configure(imageView) {
            
            $0.backgroundColor = .n30
            $0.layer.cornerRadius = 8
            $0.layer.shadowOffset = CGSize(width: -2, height: 3)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowRadius = 8
            
            $1.edges.equalToSuperview().offset(10)
            
        }
        
        imageView.configure(gradient) {
            
            let colorTop = UIColor.clear.cgColor
            let colorBottom = UIColor.black.cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.locations = [0,1]
            gradientLayer.frame = superview.bounds
            $0.layer.addSublayer(gradientLayer)
            
            $1.edges.equalToSuperview()
            
        }
        
        imageView.configure(nameLabel) {
            
            $0.textColor = .white
            $0.font = .headline1
            $0.numberOfLines = 0
            $0.textAlignment = .left
            
            $1.trailing.equalToSuperview().offset(8)
            $1.bottom.equalToSuperview().offset(12)
            
        }
        
        imageView.configure(spinner) {
            
            $0.contentMode = .scaleAspectFit
            $0.image = RAMImage.spinner.image(color: .white)
            $0.startSpinning()
            $0.isHidden = true
            
            $1.center.equalToSuperview()
            $1.width.height.equalTo(40)
            
        }
        
    }
    
} }
