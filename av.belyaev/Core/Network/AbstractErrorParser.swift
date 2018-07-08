//
//  AbstractErrorParser.swift
//  av.belyaev
//
//  Created by Артем Б on 08.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation

protocol AbsrtacrErrorParser {
    func parse(_ result: Error) -> Error
    func parse(responce: HTTPURLResponse?, data: Data?, error: Error) -> Error?
}
