//
//  ApiService.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/5/31.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import Alamofire

typealias ApiResponse = (Result<Any>) -> ()

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    let logger: Logger = PrintLogger(minimumLogLevel: .verbose)
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ApiResponse) {
        fetchFeedForUrlString("\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(_ completion: @escaping ApiResponse) {
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(_ completion: @escaping ApiResponse) {
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ApiResponse) {
        let url = URL(string: urlString)
        Alamofire.request(url!).responseJSON { (response) in
            
            self.logger.log(logLevel: .debug, "\(response)")
            
            if let error = response.error {
                completion(.failure(.unknowError(error)))
            }
            
            if let statusCode = response.response?.statusCode {
                if statusCode == 401 {
                    completion(.failure(.unauthorized))
                }
            }
            
            if response.result.isSuccess {
                let json: JSON = JSON(data: response.data!)
                DispatchQueue.main.async {
                    
                    let videos = Mapper<Video>().mapArray(JSONString: json.rawString()!)
                    completion(.success(videos!))
                    
//                    if json["Success"].boolValue == true {
//                        let returnArray = Mapper<Video>().mapArray(JSONString: rawJson!)
//                        completion(.success(videos))
//                    } else {
//                        let message = json["Message"].rawString()
//                        completion(.failure(.failedResponse(message: message!)))
//                    }
                }
            }
        }
    }
    
    
}


