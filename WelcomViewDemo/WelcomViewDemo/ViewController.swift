//
//  ViewController.swift
//  WelcomViewDemo
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let VCRect = UIScreen.main.bounds
let VCWidth = UIScreen.main.bounds.width
let VCHeight = UIScreen.main.bounds.height

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollBackground = UIScrollView(frame: VCRect)
    let images = ["full2.1","full2.2","full2.3","full2.4"]
    // 设置下面滑动图标高度
    let pageControl = UIPageControl(frame: CGRect(x: 0, y: VCHeight-20, width: VCWidth, height: 10))
    var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupView()
    }
    
    func setupView() {
        for(index, value) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: VCWidth*CGFloat(index), y: 0, width: VCWidth, height: VCHeight))
            imageView.image = UIImage(named: value)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            scrollBackground.addSubview(imageView)
        }
        
        scrollBackground.delegate = self
        scrollBackground.isPagingEnabled = true
        scrollBackground.contentSize = CGSize(width: VCWidth*CGFloat(images.count), height: VCHeight)
        
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = images.count
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        view.addSubview(scrollBackground)
        view.addSubview(pageControl)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let number = Int(round(scrollBackground.contentOffset.x/VCWidth))
        if number >= 0 && number < images.count && number != currentPage {
            currentPage = number
            pageControl.currentPage = currentPage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

