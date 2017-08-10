//
//  CustomCell.swift
//  NetPictures
//
//  Created by xuyang on 2017/8/8.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let nickname = UILabel()
    let detail = UILabel()
    let headerImage = UIImageView()
    let showImage = UIImageView()
    let title = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headerImage.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
        headerImage.contentMode = .scaleAspectFill
        headerImage.layer.cornerRadius = 20
        headerImage.clipsToBounds = true
        
        nickname.frame = CGRect(x: 60, y: 10, width: XYWidth-60, height: 20)
        nickname.font = UIFont.systemFont(ofSize: 18)
        nickname.textColor = .black
        
        detail.frame = CGRect(x: 60, y: 30, width: XYWidth-60, height: 20)
        detail.font = UIFont.systemFont(ofSize: 12)
        detail.adjustsFontSizeToFitWidth = true
        detail.textColor = .gray
        
        title.frame = CGRect(x: 10, y: 60, width: XYWidth-20, height: 20)
        title.font = UIFont.systemFont(ofSize: 18)
        title.adjustsFontSizeToFitWidth = true
        title.textColor = .black
        
        showImage.frame = CGRect(x: 10, y: 90, width: XYWidth-20, height: XYWidth-20)
        showImage.contentMode = .scaleAspectFill
        showImage.clipsToBounds = true
        
        addSubview(headerImage)
        addSubview(nickname)
        addSubview(detail)
        addSubview(title)
        addSubview(showImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
