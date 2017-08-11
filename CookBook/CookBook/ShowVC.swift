//
//  ShowVC.swift
//  CookBook
//
//  Created by xuyang on 2017/8/10.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import WebKit

class ShowVC: UIViewController, WKNavigationDelegate {
    
    var id = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        let web = WKWebView(frame: XYNoNavRect)
        web.navigationDelegate = self
        view.addSubview(web)
        guard id != 0 else {
            return
        }
        NetManager.share.HUDShow()
        web.load(URLRequest(url: URL(string: "http://wp.asopeixun.com/?p=\(id)")!))
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载网页")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("加载到网页")
        NetManager.share.HUDHide()
    }
}
