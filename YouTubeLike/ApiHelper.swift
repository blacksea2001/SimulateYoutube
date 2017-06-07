//
//  ApiHelper.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/5/28.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ApiError: Error {
    case failedResponse(message: String)
    case serviceError
    case unauthorized
}

enum Result<T> {
    case success(T)
    case failure(ApiError)
}

