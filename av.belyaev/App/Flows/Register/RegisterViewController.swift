/**
 * Контроллер регистрации пользователя
 */

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userNameView: CompositeTextField!
    @IBOutlet weak var cardView: CompositeTextField!
    @IBOutlet weak var emailView: CompositeTextField!
    @IBOutlet weak var aboutView: CompositeTextView!
    @IBOutlet weak var genderView: CompositeSegmentedControl!
    @IBOutlet weak var passwordView: CompositeTextField!
    @IBOutlet weak var confirmPasswordVoew: CompositeTextField!
    
    let registerRequestFactory: AuthRequestFactory = RequestFactory().makeAuthRequestFactory()
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeOnKeyboardNotification()
        hideKeyboardGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        unsubscribeOnKeyboardNotification()
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
                    self.saveInUserDefaults()
                    self.performSegue(withIdentifier: "unwindToUserData", sender: self)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveInUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "isAuth")
        userDefaults.set(userData.userName, forKey: "firstName")
    }
}
