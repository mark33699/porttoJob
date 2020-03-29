//
//  AppDelegate.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/27.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #endif
        
//        let vc = CollectionListViewController(viewModel: .init())
        let vc = RootViewController()
        let nc = UINavigationController.init(rootViewController: vc)
        window?.rootViewController = nc
        return true
    }
}

