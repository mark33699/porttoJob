//
//  PorttoBaseClass.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit

class PorttoBaseClass
{
    deinit
    {
        print("\(Self.self) deinit")
    }
}

class PorttoBaseViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
    }
    
    deinit
    {
        print("\(Self.self) deinit")
    }
}
