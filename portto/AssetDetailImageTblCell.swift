//
//  AssetDetailImageTblCell.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class AssetDetailImageTblCell: PorttoBaseTableViewCell
{
    private lazy var assetImageView: UIImageView =
    {
        let imgv = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        imgv.contentMode = .scaleAspectFit
        imgv.backgroundColor = .brown
        imgv.clipsToBounds = true
        return imgv
    }()

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    private func layoutUI()
    {
        contentView.addSubview(assetImageView)
    }

    override func prepareForReuse()
    {
        super.prepareForReuse()
        assetImageView.snp.removeConstraints()
    }
    
    func updateUI(url: String)
    {
        if let url = URL.init(string: url)
        {
            //取得圖片 > 算出比例 > 以寬度為準去調整高度
            KingfisherManager.shared.retrieveImage(with: url)
            { result in
                
                switch result {
                case .success(let value):
                    
                    let realImageSize = AVMakeRect(aspectRatio: value.image.size, insideRect: self.assetImageView.frame).size
                    let ratio = realImageSize.height / realImageSize.width

                    if ratio > 0
                    {
                        self.assetImageView.image = value.image
                        self.assetImageView.snp.makeConstraints
                        { (maker) in
                            
                            maker.top.equalToSuperview()
                            maker.left.equalToSuperview()
                            maker.right.equalToSuperview()
                            maker.bottom.equalToSuperview().offset(-margin)
                            maker.height.equalTo(self.assetImageView.snp.width).multipliedBy(ratio)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
