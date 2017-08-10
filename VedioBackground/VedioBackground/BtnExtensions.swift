//
//  BtnExtensions.swift
//  VedioBackground
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func customBtn(customTitle title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.5
    }
}
