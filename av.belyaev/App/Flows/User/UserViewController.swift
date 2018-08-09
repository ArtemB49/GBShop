/**
 * Контроллер данных пользователя
 */

import UIKit
import Crashlytics

class UserViewController: UIViewController, TrackableMixin {
    
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
        
        if authUserDefaultsFactory.isCancelButtonNotTap() {
            if authUserDefaultsFactory.isAuth() {
                titleLabel.text = UserVCConstants.titleData.rawValue
                firstNameLabel.text = authUserDefaultsFactory.firstName
                lastNameLabel.text = authUserDefaultsFactory.lastName
            } else {
                titleLabel.text = UserVCConstants.titleNeedEnter.rawValue
                firstNameLabel.text = nil
                lastNameLabel.text = nil
                performSegue(
                    withIdentifier: UserVCConstants.authSegue.rawValue,
                    sender: self
                )
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
                    self.performSegue(
                        withIdentifier: UserVCConstants.authSegue.rawValue,
                        sender: self
                    )
                    self.track(AnalyticsEvent.logout)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == UserVCConstants.changeUserSegue.rawValue {
            let navVC = segue.destination as? UINavigationController
            let changeUserVC = navVC?.viewControllers[0] as? ChangeUserDataViewController
            changeUserVC?.userData = UserData(
                userID: authUserDefaultsFactory.userID ?? 1,
                userName: authUserDefaultsFactory.userName ?? "",
                password: "",
                email: "",
                gender: "",
                creditCard: "",
                bio: ""
            )
        }
    }

}
