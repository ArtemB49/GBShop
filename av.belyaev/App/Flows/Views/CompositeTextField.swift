/**
 * Кастомное View в основе UITextField
 */

import UIKit

@IBDesignable
final class CompositeTextField: UniversalSetupableView {
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    private let dataContainerView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10.0
        return view
    }()
    
    private let titleImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private let inputTextField: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.adjustsFontSizeToFitWidth = true
        view.textColor = UIColor.black.withAlphaComponent(0.87)
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        return view
    }()
    
    private lazy var springView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    @IBInspectable
    var titleImage: UIImage? {
        get {
            return titleImageView.image
        }
        set {
            titleImageView.image = newValue?.withRenderingMode(.alwaysTemplate)
            titleImageView.isHidden = newValue == nil
        }
    }
    
    @IBInspectable
    var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    @IBInspectable
    var text: String {
        get {
            return inputTextField.text ?? ""
        }
        set {
            inputTextField.text = newValue
        }
    }
    enum ContentType: Int {
        case userName
        case password
        case creditCard
        case email
    }
    
    @IBInspectable
    var contentType: Int {
        get {
            // TODO: Доделать
            return 1
        }
        set {
            switch ContentType.init(rawValue: newValue)! {
            case .creditCard:
                inputTextField.textContentType = UITextContentType.creditCardNumber
            case .email:
                inputTextField.textContentType = UITextContentType.emailAddress
            case .userName:
                inputTextField.textContentType = UITextContentType.username
            case .password:
                inputTextField.textContentType = UITextContentType.password
            }
        }
    }
    
    
    override func configure() {
        dataContainerView.addArrangedSubview(titleImageView)
        dataContainerView.addArrangedSubview(titleLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(inputTextField)
        containerView.addArrangedSubview(springView)
        
        addSubview(containerView)
    }
    
    override func setupConstraints() {
        
        titleImageView.snp.makeConstraints { maker in
            maker.width.height.equalTo(20).priority(999)
        }
        titleLabel.snp.makeConstraints { maker in
            maker.height.equalTo(20)
        }
        
        inputTextField.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(25)
        }
        
        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(5)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottom.equalToSuperview()
        }
        
        
    }
}
