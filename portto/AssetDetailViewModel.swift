//
//  AssetDetailViewModel.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit

class AssetDetailViewModel: PorttoBaseClass
{
    let currentAsset: Asset
    
    init(currentAsset: Asset)
    {
        self.currentAsset = currentAsset
    }
}
