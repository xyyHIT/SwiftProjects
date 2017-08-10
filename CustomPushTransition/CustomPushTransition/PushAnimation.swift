//
//  PushAnimation.swift
//  CustomPushTransition
//
//  Created by xuyang on 2017/8/6.
//  Copyright © 2017年 www.xyy.com. All rights reserved.
//

import UIKit

class PushAnimation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        //目标VC
        let toVC = transitionContext.viewController(forKey: .to)
        
        let fromVC = transitionContext.viewController(forKey: .from)
        
        let containerView = transitionContext.containerView
        containerView.addSubview((fromVC?.view)!)
        containerView.addSubview((toVC?.view)!)
        
        let startPath = UIBezierPath(rect: CGRect(x: 0, y: XYHeight*0.5-2, width: XYWidth, height: 4))
        let finalPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: XYWidth, height: XYHeight))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        toVC?.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = finalPath.cgPath
        animation.duration = transitionDuration(using: transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        maskLayer.add(animation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext?.completeTransition(!((transitionContext?.transitionWasCancelled)!))
        transitionContext?.viewController(forKey: .from)?.view.layer.mask = nil
        transitionContext?.viewController(forKey: .to)?.view.layer.mask = nil
    }
}
