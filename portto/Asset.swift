//
//  Asset.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import Foundation

struct AssetResponse: Codable
{
    let assets: [Asset]?
}

struct Asset: Codable
{
    let name: String?
    let imageURL: String?
    let description: String?
    let permalink: String?
    let collection: Collection?

    enum CodingKeys: String, CodingKey
    {
        case imageURL = "image_url"
        case name
        case permalink
        case collection
        case description
    }
}

struct Collection: Codable
{
    let name: String?
    let description: String?
    let shortDescription: String?

    enum CodingKeys: String, CodingKey
    {
        case shortDescription = "short_description"
        case name
        case description
    }
}
