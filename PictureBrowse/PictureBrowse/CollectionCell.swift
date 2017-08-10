//
//  CollectionCell.swift
//  PictureBrowse
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    let featureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ItemWidth, height: ItemHeight))
    
    let titleLabel = UILabel(frame: CGRect(x: 0, y: ItemHeight-50, width: ItemWidth, height: 20))
    let detailLabel = UILabel(frame: CGRect(x: 0, y: ItemHeight-30, width: ItemWidth, height: 30))
    var data: CollectionCellModel? {
        didSet{
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.backgroundColor = .lightGray
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: 4)
        detailLabel.backgroundColor = .gray
        detailLabel.textColor = .white
        detailLabel.textAlignment = .center
        detailLabel.numberOfLines = 8
        detailLabel.font = UIFont.systemFont(ofSize: 10)
        contentView.addSubview(featureImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        featureImageView.image = data?.featuredImage
        titleLabel.text = data?.title
        detailLabel.text = data?.desc
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        featureImageView.clipsToBounds = true
    }
    
}
