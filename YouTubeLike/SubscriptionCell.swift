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
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
