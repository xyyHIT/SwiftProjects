//
//  CollectionCellModel.swift
//  PictureBrowse
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class CollectionCellModel: NSObject {
    var title: String?
    var desc: String?
    var featuredImage: UIImage?
    
    init(title: String, desc: String, featuredImage: UIImage) {
        self.title = title
        self.desc = desc
        self.featuredImage = featuredImage
    }
    
    static func createInterests() -> [CollectionCellModel] {
        return [
            CollectionCellModel(title: "Hello 111 missing U", desc: "aaaaaaaaa", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 222 missing U", desc: "bbbbbbbbb", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 333 missing U", desc: "ccccccccc", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 444 missing U", desc: "ddddddddd", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 555 missing U", desc: "eeeeeeeee", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 666 missing U", desc: "fffffffff", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 777 missing U", desc: "ggggggggg", featuredImage: UIImage(named: "1.3")!),
            CollectionCellModel(title: "Hello 888 missing U", desc: "hhhhhhhhh", featuredImage: UIImage(named: "1.3")!)
        ]
    }
    
}
