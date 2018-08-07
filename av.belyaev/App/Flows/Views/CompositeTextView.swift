/**
 * Кастомное View в основе UITextView
 */

import UIKit
import SnapKit

@IBDesignable
final class CompositeTextView: UniversalSetupableView {
    
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
            return inputTextView.text ?? ""
        }
        set {
            inputTextView.text = newValue
        }
    }
    
    @IBInspectable
    var accessibility: String = " " {
        didSet {
            inputTextView.accessibilityLabel = accessibility
        }
    }

    override func configure() {
        dataContainerView.addArrangedSubview(titleImageView)
        dataContainerView.addArrangedSubview(titleLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(inputTextView)
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
