//
//  CollectionDetailLabelTblCell.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit

class CollectionDetailLabelTblCell: PorttoBaseTableViewCell
{
    private lazy var collectionLabel: UILabel =
    {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.backgroundColor = .systemBlue
        lb.numberOfLines = 0
        return lb
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
        contentView.addSubview(collectionLabel)
        collectionLabel.snp.makeConstraints
        { (maker) in
            
            maker.top.equalToSuperview().offset(margin)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-margin)
        }
    }

    override func prepareForReuse()
    {
        super.prepareForReuse()
        collectionLabel.text = ""
    }
    
    func updateUI(text: String)
    {
        collectionLabel.text = text
    }
}
