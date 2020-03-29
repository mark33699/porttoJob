//
//  AppCoordinator.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/30.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import XCoordinator

enum AppRoute: Route
{
    case assetList
}

class AppCoordinator: NavigationCoordinator<AppRoute>
{
    init()
    {
        super.init(initialRoute: .assetList)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition
    {
        switch route
        {
            case .assetList:
//                return .push(AssetCoordinator().strongRouter)
                return .present(AssetCoordinator().strongRouter)
        }
    }
}
