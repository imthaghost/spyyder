//
//  UINavigationController+extensions.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 2/6/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit

extension UINavigationController {
/// reset rootVC with left or right push transition
    func initRootVC(vc: UIViewController, fromRight: Bool = true, duration: CFTimeInterval = 0.3) {
        self.addPushTransition(fromRight: fromRight, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(vc, animated: false)
        self.popToRootViewController(animated: false)
    }
/// add a left or right push transition
    private func addPushTransition(fromRight: Bool = true, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = fromRight ? .fromRight : .fromLeft //left or right transition
        self.view.layer.add(transition, forKey: nil)
    }

/// MARK: Adriana's initRootVC and addTransition implementation
    /**
     It removes all view controllers from navigation controller then set the new root view controller and it pops.

     - parameter vc: root view controller to set a new
     */
    func initRootViewController(vc: UIViewController, transitionType type: String = "kCATransitionFade", duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.viewControllers.removeAll()
        self.pushViewController(vc, animated: false)
        self.popToRootViewController(animated: false)
    }

    /**
     It adds the animation of navigation flow.

     - parameter type: kCATransitionType, it means style of animation
     - parameter duration: CFTimeInterval, duration of animation
     */
    private func addTransition(transitionType type: String = "kCATransitionFade", duration: CFTimeInterval = 0.3) { //kCATransitionPush, kCATransitionFade, kCATransitionFromLeft,  kCATransitionFromRight
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType(rawValue: type) //MARK: Uncomment this if you want to specify the transitionType
        //Set transition's type to push and from right subType
//        transition.type = CATransitionType.push
//        transition.subtype = .fromRight
        self.view.layer.add(transition, forKey: nil)
    }
    
///Change the background color of the status bar and if isLightContent
    func setStatusBarColor(backgroundColor: UIColor, isLightContent: Bool = true) {
        if #available(iOS 13, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: SettingsService.grayColor]
            let titleAttributes = [
                NSAttributedString.Key.foregroundColor: SettingsService.grayColor,
//            NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
            ]
            navBarAppearance.largeTitleTextAttributes = titleAttributes
            navBarAppearance.backgroundColor = backgroundColor
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            // ADD THE STATUS BAR AND SET A CUSTOM COLOR
            let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = backgroundColor
            }
            UIApplication.shared.statusBarStyle = isLightContent ? .lightContent : .darkContent
        }
    }
}
