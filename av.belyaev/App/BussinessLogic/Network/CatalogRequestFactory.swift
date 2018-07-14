//
//  CatalogRequestFactory.swift
//  av.belyaev
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    func getCatalog(
        pageNumber: Int,
        categoryID: Int,
        completionHandler: @escaping (DataResponse<[ProductLight]>) -> Void
    )
    
    func getProduct(
        id: Int,
        completionHandler: @escaping (DataResponse<ProductFull>) -> Void
    )
}
