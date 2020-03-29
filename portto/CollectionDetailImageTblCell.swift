//
//  CollectionDetailImageTblCell.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit

class CollectionDetailImageTblCell: PorttoBaseTableViewCell
{
    private lazy var collectionImageView: UIImageView =
    {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.backgroundColor = .brown
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
        contentView.addSubview(collectionImageView)
    }

    override func prepareForReuse()
    {
        super.prepareForReuse()
        collectionImageView.snp.removeConstraints()
    }
    
    func updateUI()
    {
        collectionImageView.snp.makeConstraints
        { (maker) in
            
            maker.top.equalToSuperview().offset(margin)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-margin)
            maker.height.equalTo(128)
        }
    }
}
