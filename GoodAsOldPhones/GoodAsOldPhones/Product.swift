//
//  Product.swift
//  GoodAsOldPhones
//
//  Created by xuyang on 2017/8/4.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import Foundation

class Product {
    var name: String?
    var cellImageName: String?
    var fullScreenImageName: String?
    
    init(name: String, cellImageName: String, fullScreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullScreenImageName = fullScreenImageName
    }
}
