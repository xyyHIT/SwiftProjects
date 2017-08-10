//
//  ViewController.swift
//  CustomPushTransition
//
//  Created by xuyang on 2017/8/6.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height

class ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.layer.contents = UIImage(named: "ttt")?.cgImage
        navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(PushViewController(), animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushAnimation()
        } else {
            return nil
        }
    }

}

