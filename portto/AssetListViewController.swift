//
//  AssetListViewController.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ZVRefreshing

let margin: CGFloat = 10 //for layout
fileprivate let cellReuseIdentifier = "cell"

class AssetListViewController: PorttoBaseViewController
{
    private let viewModel: AssetListViewModel

    private var nativeAutoFooter: ZVRefreshAutoNativeFooter?
    private lazy var collectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.register(AssetListColell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        nativeAutoFooter = ZVRefreshAutoNativeFooter()
        cv.refreshFooter = nativeAutoFooter
        
        return cv
    }()
    
    //MARK: Life cycle
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: AssetListViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModelBinding()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        layoutUI()
        viewModel.fetchAssets()
        viewModel.fetchBalance()
    }
    
    private func viewModelBinding()
    {
        //update title
        viewModel.balanceSubject
            .bind
            {[weak self] balance in
                self?.title = "ETH: \(balance)"
            }.disposed(by: bag)
        
        //update cell
        viewModel.assetSubject
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: cellReuseIdentifier,
                                           cellType: AssetListColell.self))
            { (_, asset, cell) in
                cell.updateUI(asset)
            }.disposed(by: bag)
        
        //didselect
        collectionView.rx.modelSelected(Asset.self)
            .bind(to: viewModel.selectedAsset)
            .disposed(by: bag)
    }
    
    private func layoutUI()
    {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints
        { (maker) in
            
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(margin)
            maker.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(margin)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-margin)
            maker.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-margin)
        }
    }
}

extension AssetListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    //Mark: Delegate
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if indexPath.row == viewModel.assets.count - 1
        && viewModel.shouldNextPage
        {
            viewModel.fetchAssets()
        }
    }
    
    //Mark: DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = (UIScreen.main.bounds.width - margin * 3) / 2
        return CGSize.init(width: width,
                           height: width * 2)
    }
}
