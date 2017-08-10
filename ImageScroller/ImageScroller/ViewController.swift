//
//  ViewController.swift
//  ImageScroller
//
//  Created by xuyang on 2017/8/5.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

let XYRect = UIScreen.main.bounds
let XYWidth = XYRect.width
let XYHeight = XYRect.height

class ViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView(frame: XYRect)
    let imageView = UIImageView(image: UIImage(named: "rainbown"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackground()
        setupScrollView()
        setZoomScaleFor(scrollViewSize: scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        recenterImage()
    }
    
    func setBackground() {
        view.layer.contents = UIImage(named: "rainbown")?.cgImage
        let visual = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visual.frame = XYRect
        view.addSubview(visual)
    }
    
    func setupScrollView() {
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.backgroundColor = .clear
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }

    func setZoomScaleFor(scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width/imageSize.width
        let heightScale = scrollViewSize.height/imageSize.height
        let minimunScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minimunScale
        scrollView.maximumZoomScale = 5.0
    }
    
    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.bounds.size
        
        let horizentalSpace = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.height) / 2.0 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height)/2.0 : 0
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizentalSpace, verticalSpace, horizentalSpace)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

