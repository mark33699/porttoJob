//
//  CollectionListViewController.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/28.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

let margin: CGFloat = 10
fileprivate let cellReuseIdentifier = "cell"

class CollectionListViewController: PorttoBaseViewController
{
    private let viewModel: CollectionListViewModel
    private lazy var collectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let cv = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.showsVerticalScrollIndicator = false
        cv.register(CollectionListColell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        return cv
    }()
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: CollectionListViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModelBinding()
    }
    
    private func viewModelBinding()
    {
        viewModel.publishSubject
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(cellIdentifier: cellReuseIdentifier,
                                           cellType: CollectionListColell.self))
            { (_, asset, cell) in
                
                cell.updateUI(asset)
                
            }.disposed(by: bag)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        title = "ETH餘額："
        layoutUI()
        viewModel.fetchAssets()
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

extension CollectionListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    //Mark: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = CollectionDetailViewController.init(viewModel: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
