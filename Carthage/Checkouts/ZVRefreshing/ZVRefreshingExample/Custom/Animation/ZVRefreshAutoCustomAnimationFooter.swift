//
//  RefreshAutoCustomAnimationFooter.swift
//  Example
//
//  Created by zevwings on 2017/7/9.
//  Copyright © 2017年 zevwings. All rights reserved.
//

import UIKit
import ZVRefreshing

class ZVRefreshAutoCustomAnimationFooter: ZVRefreshAutoAnimationFooter {
    
    override func prepare() {
        super.prepare()
        var refreshingImages: [UIImage] = []

        for index in 1 ... 3 {
            let name = "dropdown_loading_0\(index)"
            let img = UIImage(named: name)
            refreshingImages.append(img!)
        }

        setImages(refreshingImages, for: .refreshing)
        
    }
}
