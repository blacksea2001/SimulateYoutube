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
    case failedResponse(String)
    case unauthorized
    case unknowError(Error)
}

enum Result<T> {
    case success(T)
    case failure(ApiError)
}

