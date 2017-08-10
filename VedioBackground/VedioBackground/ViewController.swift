//
//  ViewController.swift
//  VedioBackground
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height

let loginBtRect = CGRect(x: 30, y: XYHeight-150, width: XYWidth-60, height: 50)
let registBtRrct = CGRect(x: 30, y: XYHeight-75, width: XYWidth-60, height: 50)

class ViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    let playerVC = AVPlayerViewController()
    let loginBtn = UIButton(frame: loginBtRect)
    let registBtn = UIButton(frame: registBtRrct)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setMoviePlayer(path urlPath: String) {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: urlPath, ofType: "mp4")!)
        playerVC.player = AVPlayer(url: url)
        playerVC.showsPlaybackControls = false
        playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerVC.view.frame = XYRect
        playerVC.view.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(repeatPlayer), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerVC.player?.currentItem)
        view.addSubview(playerVC.view)
        view.sendSubview(toBack: playerVC.view)
        UIView.animate(withDuration: 1) { 
            self.playerVC.view.alpha = 1
            self.playerVC.player?.play()
        }
    }
    
    func repeatPlayer() {
        playerVC.player?.seek(to: kCMTimeZero)
        playerVC.player?.play()
    }
    
    func setupView() {
        view.backgroundColor = .white
        loginBtn.customBtn(customTitle: "登录")
        registBtn.customBtn(customTitle: "注册")
        
        loginBtn.addTarget(self, action: #selector(loginBtnTap(_:)), for: .touchUpInside)
        registBtn.addTarget(self, action: #selector(registBtnTap(_:)), for: .touchUpInside)
        
        view.addSubview(loginBtn)
        view.addSubview(registBtn)
    }
    
    func loginBtnTap(_ sender: UIButton) {
        setMoviePlayer(path: "moments")
    }
    
    func registBtnTap(_ sender: UIButton) {
        setMoviePlayer(path: "aaa")
    }
}

