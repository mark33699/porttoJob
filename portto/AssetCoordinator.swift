//
//  AssetCoordinator.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/30.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import XCoordinator
import SafariServices

enum AssetRoute: Route
{
    case assetList
    case assetDetail(Asset)
    case permalink(URL)
}

class AssetCoordinator: NavigationCoordinator<AssetRoute>
{
    init()
    {
        super.init(initialRoute: .assetList)
    }

    override func prepareTransition(for route: AssetRoute) -> NavigationTransition
    {
        switch route
        {
        case .assetList:
            let vm = AssetListViewModel.init(router: unownedRouter)
            let vc = AssetListViewController.init(viewModel: vm)
            return .push(vc)
        case .assetDetail(let asset):
            let vm = AssetDetailViewModel.init(currentAsset: asset, router: unownedRouter)
            let vc = AssetDetailViewController.init(viewModel: vm)
            return .push(vc, animation: .default)
        case .permalink(let url):
            let sf = SFSafariViewController.init(url: url)
            return .present(sf)
        }
    }
}
