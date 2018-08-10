/**
 * Контроллер регистрации пользователя
 */

import UIKit

class RegisterViewController: UIViewController, TrackableMixin {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameView: CompositeTextField!
    @IBOutlet weak var cardView: CompositeTextField!
    @IBOutlet weak var emailView: CompositeTextField!
    @IBOutlet weak var aboutView: CompositeTextView!
    @IBOutlet weak var genderView: CompositeSegmentedControl!
    @IBOutlet weak var passwordView: CompositeTextField!
    @IBOutlet weak var confirmPasswordVoew: CompositeTextField!
    
    let registerRequestFactory: AuthRequestFactory
        = RequestFactory().makeAuthRequestFactory()
    let authUserDefaultsFactory = UserDefaultsFactory().makeAuthFactory()
    var keyboardManager: KeyboardManager?
    
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
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        registration()
    }
    
    private lazy var userData: UserData = {
        return UserData(
            userID: 1,
            userName: userNameView.text,
            password: passwordView.text,
            email: emailView.text,
            gender: "m",
            creditCard: cardView.text,
            bio: aboutView.text
        )
    }()
    
    func registration() {
        registerRequestFactory.registration(userData: userData) { response in
            switch response.result {
            case .success(let value):
                if value.result == 1 {
                    self.authUserDefaultsFactory.saveDataAfterRegister(userData: self.userData)
                    DispatchQueue.main.async {
                        self.performSegue(
                            withIdentifier: RegisterVCConstants.unwindToUserData.rawValue,
                            sender: self)
                    }
                   self.track(AnalyticsEvent.register(method: .password, success: true))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
