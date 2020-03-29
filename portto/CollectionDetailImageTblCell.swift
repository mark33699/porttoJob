//
//  CollectionDetailImageTblCell.swift
//  portto
//
//  Created by 謝飛飛 on 2020/3/29.
//  Copyright © 2020 MarkFly. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation

class CollectionDetailImageTblCell: PorttoBaseTableViewCell
{
    private lazy var collectionImageView: UIImageView =
    {
        let imgv = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
//        let imgv = UIImageView()
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
        contentView.addSubview(collectionImageView)
    }

    override func prepareForReuse()
    {
        super.prepareForReuse()
        collectionImageView.snp.removeConstraints()
    }
    
    func updateUI(url: String)
    {
        if let url = URL.init(string: url)
        {
            KingfisherManager.shared.retrieveImage(with: url)
            { result in
                
                switch result {
                case .success(let value):
                    
                    let realImageSize = AVMakeRect(aspectRatio: value.image.size, insideRect: self.collectionImageView.frame).size
                    let ratio = realImageSize.height / realImageSize.width

                    if ratio > 0
                    {
                        self.collectionImageView.image = value.image
                        self.collectionImageView.snp.makeConstraints
                        { (maker) in
                            
                            maker.top.equalToSuperview().offset(margin)
                            maker.left.equalToSuperview()
                            maker.right.equalToSuperview()
                            maker.bottom.equalToSuperview().offset(-margin)
                            maker.height.equalTo(self.collectionImageView.snp.width).multipliedBy(ratio)
                        }
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
