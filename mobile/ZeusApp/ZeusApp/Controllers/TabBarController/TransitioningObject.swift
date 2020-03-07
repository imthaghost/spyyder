//
//  TransitioningObject.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/20/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning { //UIViewControllerAnimatedTransitioning = A set of methods for implementing the animations for a custom view controller transition.
    let tabBarController: UITabBarController
    var fromIndex: Int = 0
    
    init(tabBarController: UITabBarController, fromIndex: Int) {
        self.tabBarController = tabBarController
        self.fromIndex = fromIndex
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) {
            let fromVCFrame = fromVC.view.frame
            let leftOrRightSlide: CGFloat = tabBarController.selectedIndex > fromIndex ? 1 : -1 //compare if toIndex is greater than fromIndex, decide if it's a left ot right or right to left animation
            let width = toVC.view.frame.size.width * leftOrRightSlide
            transitionContext.containerView.addSubview(toVC.view)
            toVC.view.frame = fromVCFrame.offsetBy(dx: width, dy: 0)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: { //start the animation
                fromVC.view.frame = fromVCFrame.offsetBy(dx: -width, dy: 0)
                toVC.view.frame = fromVCFrame
            }) { (finished) in
                fromVC.view.frame = fromVCFrame
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
