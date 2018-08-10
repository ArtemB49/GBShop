/**
 * Контроллер авторизации
 */
 

import UIKit

class AuthViewController: UIViewController {
    
    let requestFactoryUserAuth: AuthRequestFactory
        = RequestFactory().makeAuthRequestFactory()
    let authUserDefaultsFactory = UserDefaultsFactory().makeAuthFactory()

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        authorization()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        authUserDefaultsFactory.pressCancelButton(flag: false)
        performSegue(withIdentifier: "unwindToUserData", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeOnKeyboardNotification()
        hideKeyboardGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        unsubscribeOnKeyboardNotification()
    }
    
    func authorization() {
        guard let username = login.text,
            let password = password.text
        else {
            return
        }
        if username == "test" && password == "test" {
            requestFactoryUserAuth.login(
                userName: username,
                password: password
            ) { response in
                switch response.result {
                case .success(let login):
                    if login.result == 1 {
                        self.authUserDefaultsFactory.saveDataAfterLogin(login: login)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "unwindToUserData", sender: self)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            AlertControllerFactory.callAlertOK(
                title: "Авторизация",
                message: "Неверный логин или пароль",
                controller: self) { _ in }
        }
        
    }
}
