/**
 *  Фабрика записи данных об авторизации в UserDefaults
 */

import Foundation

class AuthUDFactory: KeyUserDefaults {
    
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
    
    func isCancelButtonNotTap() -> Bool {
        return userDefaults.bool(forKey: cancelButtonKey)
    }
    
    func isAuth() -> Bool {
        return userDefaults.bool(forKey: isAuthKey)
    }
    
    var firstName: String? {
        get {
            return userDefaults.string(forKey: firstNameKey)
        }
        set {
            userDefaults.set(newValue, forKey: firstNameKey)
        }
    }
    
    var lastName: String? {
        get {
            return userDefaults.string(forKey: lastNameKey)
        }
        set {
            userDefaults.set(newValue, forKey: lastNameKey)
        }
    }
    
    var userID: Int? {
        get {
            return userDefaults.integer(forKey: userIDKey)
        }
        set {
            userDefaults.set(newValue, forKey: userIDKey)
        }
    }
    
    var userName: String? {
        get {
            return userDefaults.string(forKey: userNameKey)
        }
        set {
            userDefaults.set(newValue, forKey: userNameKey)
        }
    }
}
