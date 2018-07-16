//
//  ResponceCodable.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
import Alamofire

extension DataRequest {
    @discardableResult
    func respondeCodable<T: Decodable> (
        errorParser: AbsrtactErrorParser,
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<T>) -> Void)
        -> Self {
        let responseSeriaizer = DataResponseSerializer<T> { _, response, data, error in
            if let error = errorParser.parse(responce: response, data: data, error: error) {
                return .failure(error)
            }
            let result = Request.serializeResponseData(response: response, data: data, error: nil)
            switch result {
            case .success(let data):
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        return .success(value)
                    } catch {
                        let customError = errorParser.parse(error)
                        return .failure(customError)
                    }
            case .failure(let error):
                let customError = errorParser.parse(error)
                return .failure(customError)
                
            }
        }
        return response(queue: queue, responseSerializer: responseSeriaizer, completionHandler: completionHandler)
        
    }
}
