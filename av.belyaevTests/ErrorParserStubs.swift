//
//  ErrorParserStubs.swift
//  av.belyaevTests
//
//  Created by Артем Б on 14.07.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//

import Foundation
@testable import av_belyaev

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStubs: AbsrtactErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(responce: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
