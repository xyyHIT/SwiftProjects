//
//  File.swift
//  LoginView
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func modificationTextField(placeholder: String, keyboardType: UIKeyboardType, text: String?) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.text = text
        layer.cornerRadius = 5
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        textAlignment = .center
        clearButtonMode = .whileEditing
    }
}

extension UIButton {
    func modificationButton(title: String, BGColor: UIColor = .blue) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = BGColor
        layer.cornerRadius = 5
    }
}

extension Date {
    static func getCurrentTime() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return format.string(from: date)
    }
}

func logInfo(_ message: Any) {
    #if DEBUG
        print("\(Date.getCurrentTime()) | \(#line) | \(URL(fileURLWithPath: #file).lastPathComponent) || \(message)")
    #endif
}
