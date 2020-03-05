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
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
///Adds a left or right sliding VC animation on tabbar tap
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var fromIndex = 0
        for vc in viewControllers! { //get the index of current index before transitioning
            if vc == fromVC {
                break
            }
            fromIndex += 1
        }
        return TransitioningObject(tabBarController: tabBarController, fromIndex: fromIndex)
    }
}

extension MainTabBarController {
/// didSelect that gives bar item bounce animation on tap
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // find index if the selected tab bar item, then find the corresponding view and get its image, the view position is offset by 1 because the first item is the background (at least in this case)
        guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.compactMap ({ $0 as? UIImageView }).first else {
            return
        }
        // animate the imageView
//        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
