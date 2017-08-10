//
//  VideoCell.swift
//  PlayLocalVedio
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import Foundation
import UIKit

struct VideoModel {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
    let videoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: VideoScreenWidth, height: VideoScreenHeight))
    let videoTitle = UILabel(frame: CGRect(x: 0, y: VideoScreenHeight/3-50, width: VideoScreenWidth, height: 30))
    let videoSource = UILabel(frame: CGRect(x: 0, y: VideoScreenHeight/3-20, width: VideoScreenWidth, height: 20))
    
    let videoPlayer = UIImageView(frame: CGRect(x: 0, y: 0, width: VideoScreenWidth, height: VideoScreenHeight))
    
    override init(style: UITableViewCellStyle, reuseIdentifier reusedIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reusedIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func setupView() {
        videoImage.contentMode = .scaleAspectFill
        videoPlayer.contentMode = .center
        videoImage.image = UIImage(named: "playBtn")
        videoTitle.textColor = .white
        videoTitle.textAlignment = .center
        videoSource.textColor = .gray
        videoSource.font = UIFont(name: "Avenir Next", size: 16)
        videoSource.textAlignment = .center
        contentView.addSubview(videoImage)
        contentView.addSubview(videoTitle)
        contentView.addSubview(videoSource)
    }
    
    func setModel(model: VideoModel) {
        videoImage.image = UIImage(named: model.image)
        videoTitle.text = model.title
        videoSource.text = model.source
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
