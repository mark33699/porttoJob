//
//  AssetListViewModel.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import XCoordinator
import XCoordinatorRx
import Action

let ethereumAddress = "0x960DE9907A2e2f5363646d48D7FB675Cd2892e91"

class AssetListViewModel: PorttoBaseClass
{
    //MARK:- Input
    private let router: UnownedRouter<AssetRoute>
    private(set) lazy var selectedAsset = assetSelectedAction.inputs
    
    lazy var assetSelectedAction = Action<Asset, Void>
    { [unowned self] asset in
        self.router.rx.trigger(.assetDetail(asset))
    }

    init(router: UnownedRouter<AssetRoute>)
    {
        self.router = router
    }
    
    //MARK:- Output
    let assetSubject: PublishSubject<[Asset]> = PublishSubject.init()
    let balanceSubject: PublishSubject<String> = PublishSubject.init()
    var assets: Array<Asset> = []
    var shouldNextPage = true
    private let pageLimit = 20
    private var currentPage = 0
    
    func fetchAssets()
    {
        let params: Dictionary<String,Any> = ["owner":ethereumAddress,
                                              "offset":"\(currentPage)",
                                              "limit":pageLimit]
        
        AF.request("https://api.opensea.io/api/v1/assets", parameters: params).responseDecodable(of: AssetResponse.self)
        { response in
            
            if let error = response.error
            {
                print(error.localizedDescription)
                self.shouldNextPage = false
                self.assetSubject.onNext([])
            }
            else if let assetResponse = try? response.result.get(),
                    let assets = assetResponse.assets
            {
                self.currentPage += 1
                self.shouldNextPage = assets.count < self.pageLimit ? false : true
                self.assets.append(contentsOf: assets)
                self.assetSubject.onNext(self.assets)
            }
        }
    }
    
    func fetchBalance()
    {
        let etherscanAPIKey = "VHXV5AHAWQTQ1MU5BBUGKUPE34JIZTVHXB"
        let params: Dictionary<String,Any> = ["address":ethereumAddress,
                                              "module":"account",
                                              "action":"balance",
                                              "tag":"latest",
                                              "apikey":etherscanAPIKey,]
        
        AF.request("https://api.etherscan.io/api", parameters: params).responseDecodable(of: EtherscanResponse.self)
        { response in
            
            if let error = response.error
            {
                print(error.localizedDescription)
            }
            else if let etherscanResponse = try? response.result.get(),
                    let balance = etherscanResponse.result
            {
                self.balanceSubject.onNext(balance)
            }
        }
    }
}
