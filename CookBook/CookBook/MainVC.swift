//
//  MainVC.swift
//  CookBook
//
//  Created by xuyang on 2017/8/8.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import SideMenu

struct ShowData {
    var jianjie: String
    var tags: String
    var thumb_2: String
    var views: NSInteger
    var title: String
    var thumb: String
    var id: NSInteger
    var catename: String
    var subCatename: String
    var edittime: String
    var menuTitle: String
    
    static func parseData(data: Any?) -> [ShowData]? {
        if let data = data {
            var result = [ShowData]()
            let dic = data as! NSDictionary
            let arr = dic["list"] as! NSArray
            for content in arr {
                let dic = content as! NSDictionary
                let arr = dic["list"] as! NSArray
                let title = dic["title"] as! String
                for content in arr {
                    let dic = content as! NSDictionary
                    let menu = ShowData(jianjie: dic["jianjie"] as! String, tags: dic["tags"] as! String, thumb_2: dic["thumb_2"] as! String, views: dic["views"] as! NSInteger, title: dic["title"] as! String, thumb: dic["thumb"] as! String, id: dic["ID"] as! NSInteger, catename: dic["catename"] as! String, subCatename: dic["subcatename"] as! String, edittime: dic["edittime"] as! String, menuTitle: title)
                    result.append(menu)
                }
            }
            return result
        }
        return nil
    }
}

class MainVC: UIViewController {
    let tableView = UITableView(frame: XYNoNavRect, style: .plain)
    let reuseIdentifier = "MainCell"
    var datas = [ShowData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetManager.share.mainData(url: mainURL)
        NetManager.share.delegates.append(self)
        configSideMenu()
        setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupView() {
        title = "菜谱"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(showSideMenu))
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bgimg"), for: .topAttached, barMetrics: .default)
        navigationController?.navigationBar.barStyle = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(MainCustomCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
    }
    
    func showSideMenu() {
        present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func configSideMenu() {
        let menu = UISideMenuNavigationController(rootViewController: ViewController())
        menu.leftSide = true
        SideMenuManager.menuLeftNavigationController = menu
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.menuAnimationFadeStrength = 0.5
        SideMenuManager.menuShadowOpacity = 0.5
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
}

class MainCustomCell: UITableViewCell {
    let title = UILabel()
    let detail = UILabel()
    let showImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        title.frame = CGRect(x: 80, y: 10, width: XYWidth-80-40, height: 40)
        showImage.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        title.font = UIFont.systemFont(ofSize: 16)
        title.numberOfLines = 0
        title.textColor = .black
        detail.frame = CGRect(x: 80, y: 50, width: XYWidth-80-40, height: 20)
        detail.font = UIFont.systemFont(ofSize: 12)
        detail.textColor = .gray
        accessoryType = .disclosureIndicator
        
        addSubview(showImage)
        addSubview(title)
        addSubview(detail)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(data: ShowData) {
        title.text = data.title
        detail.text = data.catename
        NetManager.share.downloadImage(imageView: showImage, imageURL: URL(string: data.thumb)!)
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource, NetDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainCustomCell
        cell.buildUI(data: datas[indexPath.row])
        return cell
    }
    
    // -- Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = datas[indexPath.row]
        let show = ShowVC()
        show.id = data.id
        show.title = data.title
        navigationController?.pushViewController(show, animated: true)
    }
    
    func dataDownload<DATA>(datas: [DATA]?, type: DataType) {
        guard let datas = datas, type == DataType.MainData else {
            return
        }
        self.datas.removeAll()
        for data in datas {
            self.datas.append(data as! ShowData)
        }
        DispatchQueue.main.async {
            let data = self.datas.first
            self.title = data?.menuTitle
            self.tableView.reloadData()
            NetManager.share.HUDHide()
        }
    }
}
