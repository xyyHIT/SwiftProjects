//
//  ViewController.swift
//  SimpleClock
//
//  Created by xuyang on 2017/8/4.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let showLabel = UILabel(frame: CGRect(x: 0, y: 0, width: YHScreenWidth, height: YHScreenHeight/2))
    
    let begin = UIButton(frame: CGRect(x: 0, y: YHScreenHeight/2, width: YHScreenWidth/2, height: YHScreenHeight/2))
    let pause = UIButton(frame: CGRect(x: YHScreenWidth/2, y: YHScreenHeight/2, width: YHScreenWidth/2, height: YHScreenHeight/2))
    
    var timer: Timer?
    var n = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        setUpView()
    }
    
    func setUpView() {
        showLabel.backgroundColor = UIColor.yellow
        begin.backgroundColor = UIColor.orange
        pause.backgroundColor = UIColor.blue
        begin.setTitle("开始", for: UIControlState.normal)
        begin.setTitle("结束", for: UIControlState.selected)
        pause.setTitle("暂停", for: .normal)
        pause.setTitle("继续", for: .selected)
        [begin, pause].forEach {
            ($0.addTarget(self, action: #selector(ViewController.buttonTap(sender:)), for: .touchUpInside))
        }
        showLabel.text = "0"
        showLabel.textColor = .black
        showLabel.font = UIFont(name: "Arial", size: 60)
        showLabel.textAlignment = .center
        self.view.addSubview(begin)
        self.view.addSubview(pause)
        self.view.addSubview(showLabel)
    }
    
    @objc func buttonTap(sender: UIButton) {
        switch sender {
        case begin:
            begin.isSelected = !begin.isSelected
            begin.isSelected ? beginSC() : stopSC()
        case pause:
            pause.isSelected = !pause.isSelected
            pause.isSelected ? pauseSC() : continueSC()
        default:
            break
            
        }
    }
    
    @objc func beginSC() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeLable), userInfo: nil, repeats: true)
    }
    
    @objc func stopSC() {
        showLabel.text = "0"
        n = 0
        timer?.invalidate()
        timer = nil
    }
    
    @objc func pauseSC() {
        if !begin.isSelected {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    @objc func continueSC() {
        if !begin.isSelected {
            return
        }
        beginSC()
    }
    
    @objc func changeLable() {
        n += 1
        showLabel.text = String(n)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

