//
//  ViewController.swift
//  ChildVCTransition
//
//  Created by xuyang on 2017/8/6.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height

class ViewController: UIViewController {
    
    var currentChildNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupChildVC()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupChildVC() {
        addChildViewController(ChildAViewController())
        addChildViewController(ChildBViewController())
        
        view.addSubview((childViewControllers.first?.view)!)
        
        // 监听跳转通知
        NotificationCenter.default.addObserver(self, selector: #selector(jump), name: NSNotification.Name.init("JumpNotification"), object: nil)
        
    }
    
    func jump() {
        transition(from: currentChildNumber == 0 ? childViewControllers.first! : childViewControllers.last!, to: currentChildNumber == 0 ? childViewControllers.last! : childViewControllers.first!, duration: 1, options: currentChildNumber == 0 ? .transitionFlipFromLeft : .transitionFlipFromRight, animations: nil, completion: nil)
        currentChildNumber = currentChildNumber == 0 ? 1 : 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init("JumpNotification"), object: nil)
    }
}

