//
//  BaseCell.swift
//  YouTubeLike
//
//  Created by Wesley on 2017/5/18.
//  Copyright © 2017年 WesleyChen. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
