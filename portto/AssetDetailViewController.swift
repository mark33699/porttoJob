//
//  AssetDetailViewController.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import RxCocoa

fileprivate let imageCellReuseIdentifier = "image"
fileprivate let labelCellReuseIdentifier = "label"

class AssetDetailViewController: PorttoBaseViewController
{
    enum CellType: Int
    {
        case image
        case name
        case desc
        
        static var count: Int
        {
            return 3
        }
        
        var reuseIdentifier: String
        {
            switch self
            {
            case .image:
                return imageCellReuseIdentifier
            case .name:
                return labelCellReuseIdentifier
            case .desc:
                return labelCellReuseIdentifier
            }
        }
    }
    
    private let viewModel: AssetDetailViewModel
    private lazy var tableView: UITableView =
    {
        let tv = UITableView()
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = 100
        tv.register(AssetDetailImageTblCell.self, forCellReuseIdentifier: imageCellReuseIdentifier)
        tv.register(AssetDetailLabelTblCell.self, forCellReuseIdentifier: labelCellReuseIdentifier)
        return tv
    }()
    private lazy var button: UIButton =
    {
        let btn = UIButton()
        btn.setTitle("permalink", for: .normal)
        btn.backgroundColor = .systemTeal
        btn.rx.tap
            .bind(to: viewModel.tapPermalink)
            .disposed(by: bag)
        
        return btn
    }()
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: AssetDetailViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = viewModel.currentAsset.collection?.name
        layoutUI()
    }
    
    private func layoutUI()
    {
        view.addSubview(button)
        button.snp.makeConstraints
        { (maker) in
            
            maker.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(margin)
            maker.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-margin)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-margin)
            maker.height.equalTo(button.snp.width).multipliedBy(0.25)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints
        { (maker) in
            
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(margin)
            maker.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(margin)
            maker.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-margin)
            maker.bottom.equalTo(button.snp.top).offset(-margin)
        }
    }
}

extension AssetDetailViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        CellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cellType = CellType.init(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch cellType
        {
        case .image:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? AssetDetailImageTblCell
            {
                cell.updateUI(url: viewModel.currentAsset.imageURL ?? "")
                return cell
            }
        case .name, .desc:
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? AssetDetailLabelTblCell
            {
                cell.updateUI(text: cellType == .name ?
                    viewModel.currentAsset.name :
                    viewModel.currentAsset.description)
                return cell
            }
        }
        return UITableViewCell()
    }
}
