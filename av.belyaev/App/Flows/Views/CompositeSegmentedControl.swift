/**
 * Кастомное View в основе UISegmentedControl
 */

import UIKit
import SnapKit

@IBDesignable
final class CompositeSegmentedControl: UniversalSetupableView {
    
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
    
    private let segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.removeAllSegments()
        view.insertSegment(withTitle: "Мужчина", at: 0, animated: true)
        view.insertSegment(withTitle: "Женщина", at: 1, animated: true)
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
    
    override func configure() {
        dataContainerView.addArrangedSubview(titleImageView)
        dataContainerView.addArrangedSubview(titleLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(segmentedControl)
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
        
        segmentedControl.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(30)
        }
        
        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottom.equalToSuperview()
        }
    }
}
