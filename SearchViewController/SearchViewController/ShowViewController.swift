//
//  ShowViewController.swift
//  SearchViewController
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {
    
    let textView = UITextView(frame: XYRect)
    var province: Province!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupView() {
        title = province.name
        var str = "省会名称：\(province.name)\n拥有\(province.citys.count)个城市\n"
        for city in province.citys {
            str = "\(str)\n城市名：\(city.name)\n别名：\(city.alias)\n"
        }
        textView.text = str
        textView.font = UIFont.systemFont(ofSize: 20, weight: 5)
        textView.textColor = .orange
        textView.isEditable = false
        view.addSubview(textView)
    }

}
