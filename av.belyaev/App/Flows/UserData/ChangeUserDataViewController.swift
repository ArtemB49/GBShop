/**
 * Контроллер изменения данных пользователя
 */

import UIKit

class ChangeUserDataViewController: UIViewController {
    
    @IBOutlet weak var userNameField: CompositeTextField!
    @IBOutlet weak var emailField: CompositeTextField!
    @IBOutlet weak var cardField: CompositeTextField!
    @IBOutlet weak var passwordField: CompositeTextField!
    @IBOutlet weak var aboutField: CompositeTextView!
    @IBOutlet weak var genderField: CompositeSegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let changeUserRequestFactory: UserProfileRequestFactory =
        RequestFactory().makeChangeUserDataRequestFactory()

    var userData: UserData?
    
    override func viewDidAppear(_ animated: Bool) {
        // Подписка на уведомления клавиатура
        subscribeOnKeyboardNotification()
        hideKeyboardGesture()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // ОТписка от уведомлений клавиатуры
        unsubscribeOnKeyboardNotification()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.text = userData?.userName ?? ""
    }

    @IBAction func saveButtonDidTab(_ sender: UIButton) {
        changeUser()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToUserData", sender: self)
    }
    
    func changeUser() {
        recordingUserData()
        
        changeUserRequestFactory.changeUserData(userData: userData!) { response in
            switch response.result {
            case .success(let changeData):
                // При успешном изменении данных возвращаемся на экран с данными пользователя
                if changeData.result == 1 {
                    self.performSegue(withIdentifier: "unwindToUserData", sender: self)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Переписывает данные из полей ввода в структуру с данными
    func recordingUserData() {
        userData?.userName = userNameField.text
        userData?.password = passwordField.text
        userData?.bio = aboutField.text
        userData?.email = emailField.text
        userData?.creditCard = cardField.text
    }
    

}
