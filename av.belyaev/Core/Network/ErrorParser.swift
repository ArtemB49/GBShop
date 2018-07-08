//
//  ErrorParser.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation

class ErrorParser: AbsrtacrErrorParser {
    
    func parse(_ result: Error) -> Error {
        return result
    }
    
    func parse(responce: HTTPURLResponse?, data: Data?, error: Error? ) -> Error? {
        return error
    }
}
