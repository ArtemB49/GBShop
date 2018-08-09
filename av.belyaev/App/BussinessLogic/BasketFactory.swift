/**
 * Фабрика Корзины
 */

import Foundation

class BasketFactory {
    func makeProductFactory() -> ProductBasketFactory {
        return ProductBasketFactory()
    }
}
