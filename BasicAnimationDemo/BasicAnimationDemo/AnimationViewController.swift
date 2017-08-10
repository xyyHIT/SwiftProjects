//
//  AnimationViewController.swift
//  BasicAnimationDemo
//
//  Created by xuyang on 2017/8/7.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var animationStyle: String!
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationBegin()
    }
    
    func setupView() {
        imageView.center = view.center
        imageView.backgroundColor = .orange
        view.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    func animationBegin() {
        switch animationStyle {
            case "Position":
                positionAnimation()
            case "Opacity":
                opacityAnimation()
            case "Color":
                colorAnimation()
            case "Scale":
                scaleAnimation()
            default:
                rotationAnimation()
        }
    }
    

    func positionAnimation() {
        UIView.animate(withDuration: 0.3, animations: { 
            self.imageView.center = CGPoint(x: 50, y: 50)
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: { 
                self.imageView.center = CGPoint(x: 50, y: XYHehgit-50)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: { 
                    self.imageView.center = CGPoint(x: XYWidth-50, y: XYHehgit-50)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: { 
                        self.imageView.center = CGPoint(x: XYWidth-50, y: 50)
                    }, completion: nil)
                })
            })
        }
    }
    
    func opacityAnimation() {
        UIView.animate(withDuration: 1) { 
            self.imageView.alpha=0
        }
    }
    
    func colorAnimation() {
        UIView.animate(withDuration: 1) { 
            self.imageView.backgroundColor = .blue
        }
    }
    
    func scaleAnimation() {
        UIView.animate(withDuration: 1) { 
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }

    func rotationAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { 
            self.imageView.transform = self.imageView.transform.rotated(by: CGFloat(Double.pi))
        }) { [weak self](_) in
            if let strongSelf = self {
                strongSelf.rotationAnimation()
            }
        }
    }
    
    deinit {
        print("VC销毁了")
    }
}
