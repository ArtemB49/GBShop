/**
 * Контроллер авторизации
 */
 

import UIKit

class AuthViewController: UIViewController {
    
    let requestFactoryUserAuth: AuthRequestFactory
        = RequestFactory().makeAuthRequestFactory()

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        authorization()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        UserDefaults.standard.set(false, forKey: "cancelButton")
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
        requestFactoryUserAuth.login(
            userName: username,
            password: password
        ) { response in
            switch response.result {
            case .success(let login):
                if login.result == 1 {
                    self.saveInUserDefaults(login: login)
                    self.performSegue(withIdentifier: "unwindToUserData", sender: self)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveInUserDefaults(login: LoginResult) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "isAuth")
        userDefaults.set(login.user.firstName, forKey: "firstName")
        userDefaults.set(login.user.lastName, forKey: "lastName")
        userDefaults.set(login.user.userID, forKey: "userID")
        userDefaults.set(login.user.login, forKey: "userName")
    }
    
    
}
