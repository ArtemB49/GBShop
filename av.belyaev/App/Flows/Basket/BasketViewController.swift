/**
 * Контроллер корзины
 */

import UIKit

class BasketViewController: UIViewController {
    
    var pickerOption = ["Наличные", "Банковская карта", "Кредит"]
    let basketLogic = BasketLogic.sharedInstance

    @IBOutlet weak var paymentField: UITextField!
    @IBOutlet weak var productStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerView = UIPickerView()
        pickerView.delegate = self
        paymentField.inputView = pickerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeOnKeyboardNotification()
        hideKeyboardGesture()
        createBasketView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        unsubscribeOnKeyboardNotification()
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
            title: "Заказ №000322",
            message: "Заказ успешно принят, ожидайте звонка специалиста",
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
        
        
    }
    
}
