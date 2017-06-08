//
//  AppConfig.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/6/7.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import Foundation

enum EnvironmentUrl: String {
    
    case sit = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    case uat = "uat"
    case prod = "prod"
    
}

struct AppConfig {
    private enum AppConfigType {
        case debug
        case releaseTest
        case release
    }
    
    private static var currentConfig: AppConfigType {
        #if DEBUG
            return .debug
        #elseif RELEASETEST
            return .releaseTest
        #elseif RELEASE
            return .release
        #endif
    }
    
    static var apiServerURL: String {
        switch currentConfig {
        case .debug:
            return EnvironmentUrl.sit.rawValue
        case .releaseTest:
            return EnvironmentUrl.uat.rawValue
        case .release:
            return EnvironmentUrl.prod.rawValue
            
        }
    }
}
