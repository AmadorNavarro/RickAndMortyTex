import UIKit

extension ErrorEmptyView { final class Ui {

    // ┌──────────────────┐
    // │                  │
    // │      IMAGE       │
    // │                  │
    // │     SPINNER      │
    // │                  │
    // ├──────────────────┤
    // │   TEXT/BUTTON    │
    // └──────────────────┘
        
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let spinner = UIImageView()
    let loadingLabel = UILabel()
    let button = UIButton()
    
    init(_ superview: UIView) {
        
        superview.backgroundColor = .clear
        
        superview.configure(titleLabel) {
            
            $0.text = "common_title_something_wrong".localized
            $0.font = .headline2
            $0.textColor = .n70
            $0.isHidden = true
            
            $1.top.equalToSuperview()
            $1.centerX.equalToSuperview()
            
        }
        
        superview.configure(imageView) {
            
            $0.image = Image.empty.image
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
            $0.isHidden = true
            
            $1.top.equalTo(titleLabel.snp.bottom).offset(20)
            $1.leading.trailing.equalToSuperview()
            $1.height.equalTo($0.snp.height)
            
        }
        
        superview.configure(spinner) {
            
            $0.image = Image.spinner.image(color: .n70)
            $0.contentMode = .scaleAspectFit
            $0.startSpinning()
            $0.isHidden = true
            
            $1.center.equalToSuperview()
            $1.width.height.equalTo(56)
            
        }
        
        superview.configure(loadingLabel) {
            
            $0.text = "common_loading".localized
            $0.font = .body1
            $0.textColor = .n70
            $0.isHidden = true
            
            $1.top.equalTo(spinner.snp.bottom).offset(12)
            $1.centerX.equalTo(spinner)
            
        }
        
        superview.configure(button) {
            
            $0.backgroundColor = .clear
            $0.layer.cornerRadius = 6
            $0.layer.borderColor = UIColor.n30.cgColor
            $0.layer.borderWidth = 1
            $0.accessibilityId(.tryAgainButton)
            
            var configuration = $0.configuration ?? UIButton.Configuration.plain()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            let attributes = AttributeContainer([.font : UIFont.buttonText1, .foregroundColor : UIColor.n70])
            let title = AttributedString("common_action_try_again".localized, attributes: attributes)
            configuration.attributedTitle = title
            $0.configuration = configuration
            $0.isHidden = true
            
            $1.centerX.equalTo(imageView)
            $1.height.equalTo(36)
            $1.top.equalTo(imageView.snp.bottom).offset(20)
            $1.bottom.equalToSuperview()
            
        }
        
    }
        
} }
