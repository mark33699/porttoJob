//
//  AssetDetailViewModel.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import RxSwift
import XCoordinator
import XCoordinatorRx
import Action

class AssetDetailViewModel: PorttoBaseClass
{
    //MARK:- Input
    private let router: UnownedRouter<AssetRoute>
    private(set) lazy var tapPermalink = permalinkTappedAction.inputs
    
    private lazy var permalinkTappedAction = CocoaAction
    { [unowned self] in
        
        let url = URL.init(string: self.currentAsset.permalink!)!
        return self.router.rx.trigger(.permalink(url))
    }
    
    init(currentAsset: Asset, router: UnownedRouter<AssetRoute>)
    {
        self.currentAsset = currentAsset
        self.router = router
    }
    
    //MARK:- Output
    let currentAsset: Asset
}
