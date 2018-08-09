/**
 * Класс для работы с экранной клавматурой
 */

import UIKit

class KeyboardManager {
    
    init(scrollView: UIScrollView) {
        self.scrollView = scrollView
        hideKeyboardGesture()
    }
    
    let scrollView: UIScrollView
    
    func subscribeOnKeyboardNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWasShown(notification:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillBeHidden(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    func unsubscribeOnKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    @objc fileprivate func keyboardWasShown(notification: Notification) {
        if let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            let contentInsets = UIEdgeInsets(
                top: 0.0,
                left: 0.0,
                bottom: keyboardSize.height + 10,
                right: 0.0
            )
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc fileprivate func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    func hideKeyboardGesture() {
        scrollView
            .addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.hideKeyboard)
            )
        )
    }
}
