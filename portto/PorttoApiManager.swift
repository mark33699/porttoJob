//
//  PorttoApiManager.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import Alamofire

class PorttoApiManager: PorttoBaseClass
{
    class func fetchCollections()
    {
        let openSeaAddress = "0x960DE9907A2e2f5363646d48D7FB675Cd2892e91"
        let params: Dictionary<String,Any> = ["owner":openSeaAddress,
                                              "offset":0,
                                              "limit":20]
        
        AF.request("https://api.opensea.io/api/v1/assets", parameters: params).responseDecodable(of: AssetResponse.self)
        { response in
            
            if let assetResponse = try? response.result.get(),
               let assets = assetResponse.assets
            {
                for asset in assets
                {
                    print(asset.name)
                }
            }
        }
    }
}
