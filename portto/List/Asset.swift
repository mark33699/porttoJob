//
//  Asset.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import Foundation

// MARK: - Asset
struct Asset
{
    let tokenID: String?
    let imageURL: String?
    let name: String?
    let description: String?
    let permalink: String?
    let collection: Collection?
    
    enum CodingKeys: String, CodingKey
    {
        case tokenID = "token_id"
        case imageURL = "image_url"
//        case name
//        case permalink
//        case collection
//        case description
    }
}

// MARK: - Collection
struct Collection
{
    let name: String?
    let collectionDescription: String?
    let shortDescription: String?

    enum CodingKeys: String, CodingKey
    {
        case shortDescription = "short_description"
//        case name
    }
}
