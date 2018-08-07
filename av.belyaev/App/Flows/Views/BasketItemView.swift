/**
 * Кастомное View в основе UITextField
 */

import UIKit

@IBDesignable
final class BasketItemView: UniversalSetupableView {
    
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
    
    private let productNameLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private let buttonMinus: UIButton = {
        let view = UIButton()
        view.setTitle("-", for: .normal)
        view.backgroundColor = .blue
        view.addTarget(nil, action: #selector(minusDidTap(_:)), for: .touchUpInside)
        return view
    }()
    
    private let countLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        return view
    }()
    
    private let buttonPlus: UIButton = {
        let view = UIButton()
        view.setTitle("+", for: .normal)
        view.backgroundColor = .blue
        view.addTarget(nil, action: #selector(plusDidTap(_:)), for: .touchUpInside)
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        return view
    }()
    
    private lazy var springView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    @objc func plusDidTap(_ sender: UIButton) {
        count += 1
    }
    @objc func minusDidTap(_ sender: UIButton) {
        count -= 1
    }
    
    
    @IBInspectable
    var productName: String {
        get {
            return productNameLabel.text ?? ""
        }
        set {
            productNameLabel.text = newValue
        }
    }
    
    @IBInspectable
    var count: Int {
        get {
            return Int(countLabel.text ?? "0") ?? 0
        }
        set {
            countLabel.text = String(newValue)
            priceLabel.text = "\(newValue * price)"
        }
    }
    
    @IBInspectable
    var price: Int = 0 {
        didSet {
           priceLabel.text = "\(price * count)"
        }
    }
    
    var summ: Int {
        get {
            return Int(priceLabel.text ?? "0") ?? 0
        }
        set {
            priceLabel.text = "\(price * count)"
        }
    }

    override func configure() {
        dataContainerView.addArrangedSubview(productNameLabel)
        dataContainerView.addArrangedSubview(buttonMinus)
        dataContainerView.addArrangedSubview(countLabel)
        dataContainerView.addArrangedSubview(buttonPlus)
        dataContainerView.addArrangedSubview(priceLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(springView)
        
        addSubview(containerView)
    }
    
    override func setupConstraints() {
        
        productNameLabel.snp.makeConstraints { maker in
            maker.height.equalTo(20)
        }
        buttonMinus.snp.makeConstraints { maker in
            maker.width.height.equalTo(20).priority(999)
        }
        countLabel.snp.makeConstraints { maker in
            maker.width.equalTo(40)
        }
        buttonPlus.snp.makeConstraints { maker in
            maker.width.height.equalTo(20).priority(999)
        }
        priceLabel.snp.makeConstraints { maker in
            maker.width.equalTo(60)
        }

        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(5)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottom.equalToSuperview()
        }
        
        
    }
}
