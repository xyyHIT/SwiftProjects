//
//  ViewController.swift
//  CookBook
//
//  Created by xuyang on 2017/8/8.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import MJRefresh

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height
let XYNoNavRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight-64)
let XYNoBarRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight-49)
let XYNoNavBarRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight-49-64)

class ViewController: UIViewController {
    
    let tableView = UITableView(frame: XYRect, style: .plain)
    let reuseIdentifier = "ReuseIdentifier"
    var datas = [MenuData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.isNavigationBarHidden = true
        NetManager.share.menuData()
        NetManager.share.delegates.append(self)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        view.layer.contents = UIImage(named: "menu_bg")?.cgImage
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: XYWidth - 280)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
    }

}

struct MenuData {
    var title: String
    var type: String
    var apiURL: String
    var icon: String
    
    static func parseData(data: Any?) -> [MenuData]? {
        if let data = data {
            var result = [MenuData]()
            let dic = data as! NSDictionary
            let arr = dic["category"] as! NSArray
            for content in arr {
                let dic = content as! NSDictionary
                var menu = MenuData(title: dic["title"] as! String, type: dic["type"] as! String, apiURL: dic["apiurl"] as! String, icon: dic["icon"] as! String)
                if menu.title == "首页" {
                    menu.apiURL = mainURL
                }
                result.append(menu)
            }
            print(result)
            return result
        }
        return nil
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, NetDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let data = self.datas[indexPath.row]
        cell.selectionStyle = .gray
        cell.backgroundColor = .clear
        cell.textLabel?.text = "          " + data.title
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        let oldImage = cell.viewWithTag(1) ?? UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        cell.addSubview(oldImage)
        guard let url = URL(string: data.icon) else {
            return cell
        }
        NetManager.share.downloadImage(imageView: oldImage as! UIImageView, imageURL: url)
        return cell
    }
    // -- Delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.datas[indexPath.row]
        if ["收藏","更多"].contains(data.title) {
            
        } else {
            NetManager.share.mainData(url: data.apiURL)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func dataDownload<DATA>(datas: [DATA]?, type: DataType) {
        guard let datas = datas, type == DataType.MenuData else {
            return
        }
        for data in datas {
            self.datas.append(data as! MenuData)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            NetManager.share.HUDHide()
        }
    }
}

