//
//  ChildBViewController.swift
//  ChildVCTransition
//
//  Created by xuyang on 2017/8/6.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class ChildBViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(transitionVC))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func transitionVC() {
        NotificationCenter.default.post(name: NSNotification.Name.init("JumpNotification"), object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
