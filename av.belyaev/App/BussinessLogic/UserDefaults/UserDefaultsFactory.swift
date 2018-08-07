/**
 *  Фабрика UserDefaults
 */

import Foundation

class UserDefaultsFactory {
    
    func makeAuthFactory() -> AuthUserDefaultsFactory {
        return AuthUserDefaultsFactory()
    }

}
