/**
 * Миксин для аналитики
 */

import Foundation
import Crashlytics

enum AnalyticsEvent {
    enum LoginMethod: String {
        case password
    }
    
    enum RegisterMethod: String {
        case password
    }
    
    case login(method: LoginMethod, success: Bool)
    case logout
    case register(method: RegisterMethod, success: Bool)
    case showCatalog
    case showProduct(nameProduct: String)
    case addToBasket(nameProduct: String)
    case deleteFromBasket(nameProduct: String)
    case paymentOrder(numberOrder: String)
    case addReview(stars: Int)
}

protocol TrackableMixin {
    func track(_ event: AnalyticsEvent)
}

extension TrackableMixin {
    func track(_ event: AnalyticsEvent) {
        switch event {
        case let .login(method, success):
            let success = NSNumber(value: success)
            Answers.logLogin(withMethod: method.rawValue, success: success, customAttributes: [:])
        case .logout:
            Answers.logCustomEvent(withName: "logout", customAttributes: [:])
        case let .register(method, success):
            let success = NSNumber(value: success)
            Answers.logSignUp(withMethod: method.rawValue, success: success, customAttributes: [:])
        case .showCatalog:
            Answers.logCustomEvent(withName: "Show Catalog", customAttributes: [:])
        case let .showProduct(nameProduct):
            Answers.logCustomEvent(withName: "Show Product", customAttributes: ["name": nameProduct])
        case let .addToBasket(nameProduct):
            Answers.logCustomEvent(withName: "Add To Basket", customAttributes: ["name": nameProduct])
        case let .deleteFromBasket(nameProduct):
            Answers.logCustomEvent(withName: "Delete From Basket", customAttributes: ["name": nameProduct])
        case let .paymentOrder(numberOrder):
            Answers.logCustomEvent(withName: "Payment Order", customAttributes: ["order": numberOrder])
        case let .addReview(stars):
            Answers.logCustomEvent(withName: "Add Review", customAttributes: ["stars": stars])
        }
    }
}
