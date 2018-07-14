//
//  CatalogResult.swift
//  av.belyaev
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation


struct ProductLight: Codable {
    let id: Int
    let name: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price = "price"
    }
}
