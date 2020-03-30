//
//  AppDelegate.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/27.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
//    var window: UIWindow?
    private lazy var mainWindow = UIWindow()
    private let router = AssetCoordinator().strongRouter

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        router.setRoot(for: mainWindow)
        return true
    }
}

