//
//  CollectionListViewModel.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class CollectionListViewModel: PorttoBaseClass
{
    let publishSubject: PublishSubject<[Asset]> = PublishSubject.init()
    var assets: Array<Asset> = []
    var shouldNextPage = true
    private let pageLimit = 20
    private var currentPage = 0
    
    func fetchAssets()
    {
        let openSeaAddress = "0x960DE9907A2e2f5363646d48D7FB675Cd2892e91"
        let params: Dictionary<String,Any> = ["owner":openSeaAddress,
                                              "offset":currentPage,
                                              "limit":pageLimit]
        
        AF.request("https://api.opensea.io/api/v1/assets", parameters: params).responseDecodable(of: AssetResponse.self)
        { response in
            
            if let error = response.error
            {
                print(error.localizedDescription)
                self.shouldNextPage = false
                self.publishSubject.onNext([])
            }
            else if let assetResponse = try? response.result.get(),
                    let assets = assetResponse.assets
            {
                self.currentPage += 1
                self.shouldNextPage = assets.count < self.pageLimit ? false : true
                self.assets.append(contentsOf: assets)
                self.publishSubject.onNext(self.assets)
            }
        }
    }
}
