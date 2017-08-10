//
//  ViewController.swift
//  LoginView
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height

class ViewController: UIViewController {
    
    let nameField = UITextField(frame: CGRect(x: 20, y: XYHeight/2, width: XYWidth-40, height: 30))
    let pwdField = UITextField(frame: CGRect(x: 20, y: XYHeight/2+30+10, width: XYWidth-40, height: 30))
    let loginBtn = UIButton(frame: CGRect(x: 20, y: XYHeight/2+30+30+30, width: XYWidth-40, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        view.backgroundColor = .white
        nameField.modificationTextField(placeholder: "用户名", keyboardType: .numberPad, text: nil)
        pwdField.modificationTextField(placeholder: "密码", keyboardType: .asciiCapable, text: nil)
        loginBtn.modificationButton(title: "登录")
        
        view.addSubview(nameField)
        view.addSubview(pwdField)
        view.addSubview(loginBtn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenKeyBoard), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func showKeyboard(notice: Notification) {
        let keyboardHeight = (notice.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        logInfo("键盘高度：\(keyboardHeight)")
        if keyboardHeight/2 == -view.frame.origin.y {
            logInfo("无需再次移动！")
            return
        }
        UIView.animate(withDuration: 1) { 
            self.view.frame = CGRect(x: 0, y: -keyboardHeight/2, width: XYWidth, height: XYHeight)
        }
    }

    func hiddenKeyBoard(notice: Notification) {
        if view.frame.origin.x == 0 {
            logInfo("无需再次复位")
        }
        UIView.animate(withDuration: 1) { 
            self.view.frame = XYRect
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

