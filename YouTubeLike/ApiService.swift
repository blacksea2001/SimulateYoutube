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

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    let logger: Logger = PrintLogger(minimumLogLevel: .verbose)
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/home_num_likes.json", completion: completion)
        
//        fetchFeedForUrlString("\(baseUrl)/home_num_likes.json") { (videos) in
//            completion(videos)
//        }
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let _ = error {
                return
            }
            
            var videos = [Video]()
            
            let json = JSON(data: data!).rawString()
            videos = Mapper<Video>().mapArray(JSONString: json!)!
            self.logger.log(logLevel: .debug, "\(String(describing: videos))")
            
            DispatchQueue.main.async {
                completion(videos)
            }
        }.resume()
    }
    
    
    
    
    
}


