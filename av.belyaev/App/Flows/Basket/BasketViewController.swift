/**
 * Контроллер корзины
 */

import UIKit

class BasketViewController: UIViewController, TrackableMixin {
    
    var pickerOption = ["Наличные", "Банковская карта", "Кредит"]
    let basketLogic = BasketLogic.sharedInstance
    var keyboardManager: KeyboardManager?
    
    lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        return view
    }()

    @IBOutlet weak var paymentField: UITextField!
    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentField.inputView = pickerView
        keyboardManager = KeyboardManager(scrollView: scrollView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        keyboardManager?.subscribeOnKeyboardNotification()
        
        createBasketView()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        keyboardManager?.unsubscribeOnKeyboardNotification()
        self.productStackView.safelyRemoveArrangedSubviews()
    }
    
    // Заполняет StackView товарами
    func createBasketView() {
        basketLogic.products.forEach { (product) in
            DispatchQueue.main.async {
                let productStackViewWidth = self.productStackView.frame.width
                let basketView = BasketItemView()
                basketView.count = 1
                basketView.price = product.price
                basketView.productName = product.name
                basketView
                    .widthAnchor
                    .constraint(equalToConstant: productStackViewWidth)
                    .isActive = true
                basketView
                    .heightAnchor
                    .constraint(equalToConstant: 40)
                    .isActive = true
                self.productStackView.translatesAutoresizingMaskIntoConstraints = false
                self.productStackView.addArrangedSubview(basketView)
            }
        }
    }

    @IBAction func orderButtonDidTap(_ sender: UIButton) {
        AlertControllerFactory.callAlertOK(
            title: BasketVCConstants.titleAlertOrder.rawValue,
            message: BasketVCConstants.messageAlertOrder.rawValue,
            controller: self
        ) { _ in
            self.tabBarController?.selectedIndex = 0
            self.basketLogic.products.removeAll()
            if let tabController = self.tabBarController,
                let tabItems = tabController.tabBar.items {
                tabItems[1].badgeValue = nil
                tabItems[1].isEnabled = false
            }
        }
        track(AnalyticsEvent.paymentOrder(numberOrder: "000322"))
        
    }
    
}
