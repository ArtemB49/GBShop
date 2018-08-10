/**
 *  Фабрика UserDefaults
 */

import Foundation

class UserDefaultsFactory {
    
    func makeAuthFactory() -> AuthUDFactory {
        return AuthUDFactory()
    }

}
