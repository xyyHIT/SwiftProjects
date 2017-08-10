//
//  ViewController.swift
//  SearchViewController
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

struct City {
    let name, alias: String
}

struct Province {
    var name: String
    var namePY: String
    var citys: [City]
}

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height
let XYNoNavRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight-64)
let XYNoBarRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight-49)
let XYNoNavBarRect = CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight-49-64)

class ViewController: UIViewController {
    
    var searchController: UISearchController!
    var searchResultTableViewController: SearchResultTableViewController!
    var datas = [Province]()
    var tableView = UITableView(frame: XYRect, style: .plain)
    let reuseIdentifer = "TableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getPlistData() {
        let dic = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "Provice", ofType: "plist")!)
        dic?.enumerateKeysAndObjects({ (key, value, roolback) in
            let values = value as! NSDictionary
            var citys = [City]()
            for k in values.allKeys {
                let city = City(name: k as! String, alias: values[k] as! String)
                citys.append(city)
            }
            let province = Province(name: key as! String, namePY: transformToPY(str: key as! String), citys: citys)
            datas.append(province)
        })
    }
    
    func transformToPY(str: String) -> String {
        var py = NSMutableString(string: str)
        CFStringTransform(py as CFMutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(py as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
        let arr = py.components(separatedBy: " ")
        py = ""
        for str in arr {
            py.append(str.substring(to: str.index(after: str.startIndex)))
        }
        print(py)
        return py as String
    }
    
    func setupView() {
        title = "所有省份"
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        view.addSubview(tableView)
        
        searchResultTableViewController = SearchResultTableViewController(style: .plain)
        searchResultTableViewController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: searchResultTableViewController)
        
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.keyboardType = .default
        searchController.searchBar.placeholder = "可以输入拼音的首字母进行搜索"
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        let data = datas[indexPath.row]
        cell.textLabel?.text = data.name
        cell.textLabel?.textColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let show = ShowViewController()
        show.province = datas[indexPath.row]
        self.navigationController?.pushViewController(show, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let strIn = searchController.searchBar.text!
        print("输入：\(strIn)")
        let result = datas.filter({$0.namePY.contains(strIn.lowercased()) || $0.name.contains(strIn)})
        print("搜索结果:\(result.count)")
        searchResultTableViewController.datas = result
        searchResultTableViewController.tableView.reloadData()
    }
}

