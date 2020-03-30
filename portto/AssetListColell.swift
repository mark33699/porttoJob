//
//  AssetListColell.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SDWebImage

class AssetListColell: UICollectionViewCell
{
    private lazy var label: UILabel =
    {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.backgroundColor = .systemBlue
        return lb
    }()
    private lazy var imageView: UIImageView =
    {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.backgroundColor = .brown
        imgv.clipsToBounds = true
        return imgv
    }()
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        layoutUI()
    }
    
    private func layoutUI()
    {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints
        { (maker) in
            
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalTo(imageView.snp.width).multipliedBy(1.5)
        }
        
        contentView.addSubview(label)
        label.snp.makeConstraints
        { (maker) in
            
            maker.top.equalTo(imageView.snp.bottom).offset(margin)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        label.text = ""
    }
    
    func updateUI(_ asset: Asset)
    {
        label.text = asset.name
        if let imgUrl = asset.imageURL
        {
            let url = URL.init(string: imgUrl)
            imageView.sd_setImage(with: url)
        }
    }
}
