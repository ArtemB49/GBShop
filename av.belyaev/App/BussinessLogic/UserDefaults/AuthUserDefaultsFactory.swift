/**
 *  Фабрика записи данных об авторизации в UserDefaults
 */

import Foundation

class AuthUserDefaultsFactory: KeyUserDefaults {
    
    func saveDataAfterLogin(login: LoginResult) {
        userDefaults.set(true, forKey: isAuthKey)
        userDefaults.set(login.user.firstName, forKey: firstNameKey)
        userDefaults.set(login.user.lastName, forKey: lastNameKey)
        userDefaults.set(login.user.userID, forKey: userIDKey)
        userDefaults.set(login.user.login, forKey: loginKey)
    }
    
    func pressCancelButton(flag: Bool) {
        userDefaults.set(flag, forKey: cancelButtonKey)
    }
    
    func cleanUserData() {
        userDefaults.set(false, forKey: isAuthKey)
        userDefaults.removeObject(forKey: firstNameKey)
        userDefaults.removeObject(forKey: lastNameKey)
        userDefaults.removeObject(forKey: userIDKey)
        userDefaults.removeObject(forKey: loginKey)
    }
    
    func saveDataAfterRegister(userData: UserData) {
        userDefaults.set(true, forKey: isAuthKey)
        userDefaults.set(userData.userName, forKey: firstNameKey)
        
    }
}
