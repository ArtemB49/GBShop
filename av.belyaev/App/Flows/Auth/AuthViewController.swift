/**
 * Контроллер авторизации
 */
 

import UIKit

class AuthViewController: UIViewController, TrackableMixin {
    
    let requestFactoryUserAuth: AuthRequestFactory
        = RequestFactory().makeAuthRequestFactory()
    let authUserDefaultsFactory
        = UserDefaultsFactory().makeAuthFactory()
    var keyboardManager: KeyboardManager?

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func loginButtonDidTouch(_ sender: UIButton) {
        authorization()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        authUserDefaultsFactory.pressCancelButton(flag: false)
        performSegue(
            withIdentifier: AuthConstants.unwindToUserData.rawValue,
            sender: self
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardManager = KeyboardManager(scrollView: self.scrollView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        keyboardManager?.subscribeOnKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        keyboardManager?.unsubscribeOnKeyboardNotification()
    }
    
    func authorization() {
        guard let username = login.text,
            let password = password.text
        else {
            return
        }
        if username == AuthConstants.defaultPasswordAndUser.rawValue
            && password == AuthConstants.defaultPasswordAndUser.rawValue {
            requestFactoryUserAuth.login(
                userName: username,
                password: password
            ) { response in
                switch response.result {
                case .success(let login):
                    if login.result == 1 {
                        self.authUserDefaultsFactory.saveDataAfterLogin(login: login)
                        DispatchQueue.main.async {
                            self.performSegue(
                                withIdentifier: AuthConstants.unwindToUserData.rawValue,
                                sender: self
                            )
                        }
                        self.track(AnalyticsEvent.login(method: .password, success: true))
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.track(AnalyticsEvent.login(method: .password, success: true))
                }
            }
        } else {
            AlertControllerFactory.callAlertOK(
                title: AuthConstants.alertTitle.rawValue,
                message: AuthConstants.alertMessage.rawValue,
                controller: self) { _ in }
            
            self.track(AnalyticsEvent.login(method: .password, success: true))
        }
        
    }
}
