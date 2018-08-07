/**
 * Синглтон хранящий товары в корзине
 */

import Foundation

class BasketLogic {
    static let sharedInstance = BasketLogic()
    
    var products = [ProductFullResult]()
}
