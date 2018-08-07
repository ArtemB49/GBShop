/**
 * Фабрика UIAlert
 */

import UIKit

class AlertControllerFactory {
    class func callAlertOK(
        title: String,
        message: String,
        controller: UIViewController,
        action: @escaping ((UIAlertAction) -> Void)
        ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: action)
        
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
