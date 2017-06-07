//
//  SubscriptionCell.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/6/7.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (result) in
            switch result {
            case .success(let list):
                self.videos = list as? [Video]
                self.collectionView.reloadData()
            case .failure(let error):
                switch error {
                case .unauthorized:
                    // do something
                    break
                default:
                    break
                }
            }
        }
    }
}
