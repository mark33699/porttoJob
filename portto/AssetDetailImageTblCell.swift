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
import SDWebImage

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
    
    func updateUI(urlString: String)
    {
        if let url = URL.init(string: urlString)
        {
            let count = urlString.count - 4
            let ext = urlString[count...]
            if ext == ".svg"
            {
                setSVGImage(url)
            }
            else
            {
                setNormalImage(url)
            }
        }
    }
    
    private func setSVGImage(_ url: URL)
    {
        self.assetImageView.sd_setImage(with: url)
        self.imageViewMakeConstraints(ratio: 1)
    }
    
    private func setNormalImage(_ url: URL)
    {
        imageViewMakeConstraints(ratio: 1)
        
        //取得圖片 > 算出比例 > 以寬度為準去調整高度
        SDWebImageManager.shared.loadImage(with: url, options: .highPriority, progress: nil)
        { (image, data, error, cache, finished, url) in

            if let error = error
            {
                print(error)
            }
            
            if let image = image, finished
            {
                let realImageSize = AVMakeRect(aspectRatio: image.size, insideRect: self.assetImageView.frame).size
                let ratio = realImageSize.height / realImageSize.width

                if ratio > 0
                {
                    self.assetImageView.image = image
                    self.assetImageView.snp.removeConstraints()
                    self.imageViewMakeConstraints(ratio: ratio)
                }
            }
        }
    }
    
    private func imageViewMakeConstraints(ratio: CGFloat)
    {
        self.assetImageView.snp.makeConstraints
        { (maker) in
            
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-margin)
            maker.height.equalTo(self.assetImageView.snp.width).multipliedBy(ratio)
        }
    }
}
