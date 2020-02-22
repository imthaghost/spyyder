//
//  MainTabBarController.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/4/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    ///Bounce animation for clicking on tabbar items
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        self.delegate = self
//        self.tabBar.isTranslucent = false
    }
}

extension MainTabBarController: UITabBarControllerDelegate {    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool { //add a sliding animation whenever switching tabs
//        if let fromView = tabBarController.selectedViewController?.view,
//            let toView = viewController.view, fromView != toView,
//            let controllerIndex = self.viewControllers?.firstIndex(of: viewController) {
//
//            let viewSize = fromView.frame
//            let scrollRight = controllerIndex > tabBarController.selectedIndex
//
//            if fromView.superview?.subviews.contains(toView) == true { // Avoid UI issues when switching tabs fast
//                return false
//            }
//
//            fromView.superview?.addSubview(toView)
//
//            let screenWidth = UIScreen.main.bounds.size.width
//            toView.frame = CGRect(x: (scrollRight ? screenWidth : -screenWidth), y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
//
//            UIView.animate(withDuration: 0.25, delay: TimeInterval(0.0), options: [.curveEaseOut, .preferredFramesPerSecond60], animations: {
//                fromView.frame = CGRect(x: (scrollRight ? -screenWidth : screenWidth), y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
//                toView.frame = CGRect(x: 0, y: viewSize.origin.y, width: screenWidth, height: viewSize.size.height)
//            }, completion: { finished in
//                if finished {
//                    fromView.removeFromSuperview()
//                    tabBarController.selectedIndex = controllerIndex
//                }
//            })
//            return true
//        }
//        return false
//    }
    
    ///Adds a sliding animation whenever switching between VC on the tab
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitioningObject()
    }
    
    /// didSelect that can trigger animation
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // find index if the selected tab bar item, then find the corresponding view and get its image, the view position is offset by 1 because the first item is the background (at least in this case)
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap ({ $0 as? UIImageView }).first else {
            return
        }
        // animate the imageView
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
