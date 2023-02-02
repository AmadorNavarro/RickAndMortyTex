import UIKit

extension CharacterView { final class Ui {

    // ┌─────────────────────────┐
    // │                         │
    // │        ┌───────┐        │
    // │        │       │        │
    // │        │ IMG   │        │
    // │        │       │        │
    // │        └───────┘        │
    // │                         │
    // │   STATUS:               │
    // │   SPECIES:              │
    // │   GENDER:               │
    // │   CREATED:              │
    // │                         │
    // │                         │
    // └─────────────────────────┘
        
    let background = UIImageView()
    let nameLabel = UILabel()
    let imageView = UIImageView()
    let statusKey = UILabel()
    let statusValue = UILabel()
    let speciesKey = UILabel()
    let speciesValue = UILabel()
    let genderKey = UILabel()
    let genderValue = UILabel()
    let createdKey = UILabel()
    let createdValue = UILabel()
    
    init(_ superview: UIView) {
        
        superview.backgroundColor = .white
        
        superview.configure(background) {
            
            $0.contentMode = .scaleAspectFill
            $0.alpha = 0.2
            $0.accessibilityId(.characterDetail)
            
            $1.edges.equalToSuperview()
            
        }
        
        superview.configure(imageView) {
            
            $0.contentMode = .scaleAspectFit
            $0.layer.masksToBounds = true
            $0.layer.borderColor = UIColor.n70.cgColor
            $0.layer.borderWidth = 2
            $0.layer.cornerRadius = 12
            
            $1.centerX.equalToSuperview()
            $1.centerY.equalToSuperview().multipliedBy(0.5)
            $1.width.height.equalTo(250)
            
        }
        
        superview.configure(nameLabel) {
            
            $0.font = .headline1
            $0.textColor = .n70
            $0.textAlignment = .center
            $0.numberOfLines = 0
            
            $1.top.equalTo(imageView.snp.bottom).offset(20)
            $1.leading.equalToSuperview().offset(30)
            $1.trailing.equalToSuperview().offset(-30)
            
        }
        
        superview.configure(statusKey) {
            
            $0.text = "character_view_status".localized
            $0.font = .headline3
            $0.textColor = .n70
            
            $1.top.equalTo(nameLabel.snp.bottom).offset(20)
            $1.leading.equalToSuperview().offset(30)
            
        }
        
        superview.configure(statusValue) {
            
            $0.font = .headline2
            $0.textColor = .n70
            
            $1.centerY.equalTo(statusKey)
            $1.leading.equalTo(statusKey.snp.trailing).offset(8)
            $1.trailing.lessThanOrEqualToSuperview().offset(-30)
            
        }
        
        superview.configure(speciesKey) {
            
            $0.text = "character_view_species".localized
            $0.font = .headline3
            $0.textColor = .n70
            
            $1.top.equalTo(statusKey.snp.bottom).offset(10)
            $1.leading.equalToSuperview().offset(30)
            
        }
        
        superview.configure(speciesValue) {
            
            $0.font = .headline2
            $0.textColor = .n70
            
            $1.centerY.equalTo(speciesKey)
            $1.leading.equalTo(speciesKey.snp.trailing).offset(8)
            $1.trailing.lessThanOrEqualToSuperview().offset(-30)
            
        }
        
        superview.configure(genderKey) {
            
            $0.text = "character_view_gender".localized
            $0.font = .headline3
            $0.textColor = .n70
            
            $1.top.equalTo(speciesKey.snp.bottom).offset(10)
            $1.leading.equalToSuperview().offset(30)
            
        }
        
        superview.configure(genderValue) {
            
            $0.font = .headline2
            $0.textColor = .n70
            
            $1.centerY.equalTo(genderKey)
            $1.leading.equalTo(genderKey.snp.trailing).offset(8)
            $1.trailing.lessThanOrEqualToSuperview().offset(-30)
            
        }
        
        superview.configure(createdKey) {
            
            $0.text = "character_view_created".localized
            $0.font = .headline3
            $0.textColor = .n70
            
            $1.top.equalTo(genderKey.snp.bottom).offset(10)
            $1.leading.equalToSuperview().offset(30)
            
        }
        
        superview.configure(createdValue) {
            
            $0.font = .headline2
            $0.textColor = .n70
            
            $1.centerY.equalTo(createdKey)
            $1.leading.equalTo(createdKey.snp.trailing).offset(8)
            $1.trailing.lessThanOrEqualToSuperview().offset(-30)
            
        }
        
    }
        
} }
