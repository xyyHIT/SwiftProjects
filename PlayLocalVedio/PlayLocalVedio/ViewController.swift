//
//  ViewController.swift
//  PlayLocalVedio
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

let VideoScreenRect: CGRect = UIScreen.main.bounds
let VideoScreenWidth: CGFloat = VideoScreenRect.width
let VideoScreenHeight: CGFloat = VideoScreenRect.height

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: VideoScreenRect)
    var playerViewController: AVPlayerViewController?
    var playerView: AVPlayer?
    let reusedIdentifer = "videoCell"

    let datas = [
        VideoModel(image: "videoScreenshot01", title: "video 01", source: "video01 - 016:32"),
        VideoModel(image: "videoScreenshot02", title: "video 02", source: "video02 - 026:32"),
        VideoModel(image: "videoScreenshot03", title: "video 03", source: "video03 - 036:32"),
        VideoModel(image: "videoScreenshot04", title: "video 04", source: "video04 - 046:32"),
        VideoModel(image: "videoScreenshot05", title: "video 05", source: "video05 - 056:32"),
        VideoModel(image: "videoScreenshot06", title: "video 06", source: "video06 - 066:32")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerView = nil
        playerViewController = nil
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: reusedIdentifer)
        view.addSubview(tableView)
    }
    
    func playVideo() {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        if path == nil {
            print("没有该文件")
            return
        }
        
        playerView = AVPlayer(url: URL(fileURLWithPath: path!))
        playerViewController = AVPlayerViewController()
        playerViewController?.player = playerView
        self.present(playerViewController!, animated: true) { 
            self.playerView?.play()
        }
    }
    
    // 实现UITalbeView代理方法
    // 设置重复次数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    // 总数据量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    // 设置行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VideoScreenHeight/3
    }
    // 设置每行的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedIdentifer, for: indexPath) as! VideoCell
        cell.setModel(model: datas[indexPath.row])
        return cell
    }
    // 点击行事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

