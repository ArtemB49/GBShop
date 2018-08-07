/**
 * Контроллер данных пользователя
 */

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    let logoutRequestFactory: AuthRequestFactory =
        RequestFactory().makeAuthRequestFactory()
    let authUserDefaultsFactory = UserDefaultsFactory().makeAuthFactory()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isCancelDidntTap = userDefaults.bool(forKey: "cancelButton")
        if isCancelDidntTap {
            let isAuth = userDefaults.bool(forKey: "isAuth")
            if isAuth {
                titleLabel.text = "Ваши данные"
                firstNameLabel.text = userDefaults.string(forKey: "firstName")
                lastNameLabel.text = userDefaults.string(forKey: "lastName")
            } else {
                titleLabel.text = "Требуется вход"
                firstNameLabel.text = ""
                lastNameLabel.text = ""
                performSegue(withIdentifier: AppConstants().authSegue, sender: self)
            }
        } else {
            authUserDefaultsFactory.pressCancelButton(flag: true)
            self.tabBarController?.selectedIndex = 0
        }
        
    }
    
    @IBAction func unwindToUserData(segue: UIStoryboardSegue) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func exitButtoDidTab(_ sender: UIButton) {
        logoutRequestFactory.logout(userID: 1) { response in
            switch response.result {
            case .success(let logout):
                if logout.result == 1 {
                    self.authUserDefaultsFactory.cleanUserData()
                    self.performSegue(withIdentifier: AppConstants().authSegue, sender: self)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == AppConstants().changeUserSegue {
            let navVC = segue.destination as? UINavigationController
            let changeUserVC = navVC?.viewControllers[0] as? ChangeUserDataViewController
            changeUserVC?.userData = UserData(
                userID: userDefaults.integer(forKey: "userID"),
                userName: userDefaults.string(forKey: "userName") ?? "",
                password: "",
                email: "",
                gender: "",
                creditCard: "",
                bio: ""
            )
        }
    }

}
