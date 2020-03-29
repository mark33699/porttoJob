//
//  PorttoBaseClass.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import RxSwift

class PorttoBaseClass
{
    deinit
    {
        print("\(Self.self) deinit")
    }
}

class PorttoBaseViewController: UIViewController
{
    let bag = DisposeBag()
    
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

class PorttoBaseTableViewCell: UITableViewCell
{
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
}

class RootViewController: UIViewController
{
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        let vc = CollectionListViewController.init(viewModel: .init())
        navigationController?.pushViewController(vc, animated: true)
    }
}
