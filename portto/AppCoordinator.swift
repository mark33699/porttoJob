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
    case asset
}

class AppCoordinator: NavigationCoordinator<AppRoute>
{
    init()
    {
        super.init(initialRoute: .asset)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition
    {
        switch route
        {
            case .asset:
                let vc = AssetListViewController.init(viewModel: .init())
                return .push(vc)
        }
    }
}
