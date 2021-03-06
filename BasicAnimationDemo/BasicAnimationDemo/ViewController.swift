//
//  ViewController.swift
//  BasicAnimationDemo
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHehgit = XYRect.height
let XYNoNavRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHehgit-64)
let XYNoBarRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHehgit-49)
let XYNoNavBarRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHehgit-64-49)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let datas = ["位置","透明度","缩放","颜色","旋转"]
    let tableView = UITableView(frame: XYRect, style: .plain)
    let reuseIdentifer = "cellStyle"

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
        title = "动画"
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30, weight: 5)
        cell.textLabel?.textColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = AnimationViewController()
        vc.title = tableView.cellForRow(at: indexPath)?.textLabel?.text
        switch indexPath.row {
        case 0:
            vc.animationStyle = "Position"
        case 1:
            vc.animationStyle = "Opacity"
        case 2:
            vc.animationStyle = "Scale"
        case 3:
            vc.animationStyle = "Color"
        default:
            vc.animationStyle = "Rotation"
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}

