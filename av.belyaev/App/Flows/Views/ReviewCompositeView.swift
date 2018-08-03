/**
 * Кастомное View для отзывов о товарах
 */

import UIKit
import SnapKit

@IBDesignable
final class ReviewCompositeView: UniversalSetupableView {
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    private let dataContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 10.0
        return view
    }()
    
    private let containerStarsView = UIView()
    
    private let starsImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = UIColor.yellow
        return view
    }()
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private let ownerNameLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private let inputTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 5.0
        view.textColor = UIColor.black.withAlphaComponent(0.87)
        view.autocapitalizationType = .none
        view.autocorrectionType = .yes
        view.spellCheckingType = .no
        return view
    }()
    
    private lazy var springView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    @IBInspectable
    var starsImage: UIImage? {
        get {
            return starsImageView.image
        }
        set {
            starsImageView.image = newValue?.withRenderingMode(.alwaysTemplate)
            starsImageView.isHidden = newValue == nil
        }
    }
    
    @IBInspectable
    var countStars: Int {
        get {
            return 1
        }
        set {
            let namesImageStars = [
                "1 stars",
                "2 stars",
                "3 stars",
                "4 stars",
                "5 stars"
            ]
            let number = ((newValue) >= 5) ? 4 : newValue
            starsImageView.image = UIImage(named: namesImageStars[number])
        }
    }
    
    @IBInspectable
    var date: String {
        get {
            return dateLabel.text ?? ""
        }
        set {
            dateLabel.text = newValue
        }
    }
    
    @IBInspectable
    var ownerName: String {
        get {
            return ownerNameLabel.text ?? ""
        }
        set {
            ownerNameLabel.text = newValue
        }
    }
    
    @IBInspectable
    var text: String {
        get {
            return inputTextView.text ?? ""
        }
        set {
            inputTextView.text = newValue
        }
    }
    
    override func configure() {
        dataContainerView.addArrangedSubview(ownerNameLabel)
        dataContainerView.addArrangedSubview(dateLabel)
        
        containerStarsView.addSubview(starsImageView)
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(containerStarsView)
        containerView.addArrangedSubview(inputTextView)
        containerView.addArrangedSubview(springView)
        
        addSubview(containerView)
    }
    
    override func setupConstraints() {
        
        ownerNameLabel.snp.makeConstraints { maker in
            maker.height.equalTo(20).priority(999)
        }
        dateLabel.snp.makeConstraints { maker in
            maker.height.equalTo(20)
        }
        
        containerStarsView.snp.makeConstraints { maker in
            maker.height.equalTo(20)
            maker.width.equalToSuperview()
        }
        
        starsImageView.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
            let superviewWidth = superview?.frame.width ?? 300
            maker.width.equalTo(superviewWidth/2)
            maker.leading.equalToSuperview().offset(superviewWidth/2)
            maker.trailing.equalToSuperview()
            maker.top.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        inputTextView.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(50)
        }
        
        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottom.equalToSuperview()
        }
    }
}
