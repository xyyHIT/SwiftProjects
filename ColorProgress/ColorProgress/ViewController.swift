//
//  ViewController.swift
//  ColorProgress
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height
let progressRect = CGRect(x: 20, y: 200, width: XYWidth-40, height: 20)

class ViewController: UIViewController {
    
    let colorProgress = ColorProgress(frame: progressRect)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
            self.colorProgress.progress += 0.08
            if self.colorProgress.progress >= 1.0 {
                time.invalidate()
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(colorProgress)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

